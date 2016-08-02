#' Convert an alignment to a BEAST2 XML input file
#' @param alignment_dnabin The alignmnet
#' @param mcmc_chainlength The length of the MCMC chain BEAST2 will generate
#' @param base_filename The base of the filename (the part without the extension)
#' @param rng_seed The random number generator seed used by BEAST2
#' @param beast_jar_path Where the jar 'beast.jar' can be found
#' @param skip_if_output_present skip if output files are present, else remove these and start a new BEAST2 run
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return the phylogenies of the BEAST2 posterior
#' @examples
#'
#'   # Prepare the many filenames
#'   base_filename <- "alignment_to_beast_posterior_example"
#'   beast_log_filename <- paste0(base_filename, ".log")
#'   beast_trees_filename <- paste0(base_filename, ".trees")
#'   beast_state_filename <- paste0(base_filename, ".xml.state")
#'
#'   # Simulate a random phylogeny its alignment
#'   alignment <- convert_phylogeny_to_alignment(
#'     phylogeny = ape::rcoal(5),
#'     sequence_length = 10,
#'     mutation_rate = 1
#'   )
#'
#'   # See if the BEAST2 .jar file is present
#'   beast_jar_path <- find_beast_jar_path()
#'   testit::assert(file.exists(beast_jar_path))
#'
#'   # Run BEAST2 and extract the phylogenies of its posterior
#'   posterior <- alignment_to_beast_posterior(
#'     alignment_dnabin = alignment,
#'     mcmc_chainlength = 10000,
#'     base_filename = base_filename,
#'     rng_seed = 42,
#'     beast_jar_path = beast_jar_path,
#'     skip_if_output_present = FALSE,
#'     verbose = FALSE
#'   )
#'
#'   # Check the posterior
#'   testit::assert(is_posterior(posterior))
#'   expected_names <- paste0("STATE_", seq(from = 1000, to = 10000, by = 1000))
#'   testit::assert(names(posterior) == expected_names)
#'   testit::assert(is_phylogeny(posterior$STATE_1000))
#'
#' @export
#' @author Richel Bilderbeek
alignment_to_beast_posterior <- function(
  alignment_dnabin,
  mcmc_chainlength,
  base_filename,
  rng_seed = 42,
  beast_jar_path = find_beast_jar_path(),
  skip_if_output_present = FALSE,
  verbose = FALSE
) {
  if (!is_alignment(alignment_dnabin)) {
    stop("alignment_to_beast_posterior: ",
      "alignment must be of class DNAbin"
    )
  }
  if (!is_whole_number(mcmc_chainlength)) {
    stop("alignment_to_beast_posterior: ",
      "mcmc_chainlength must be a whole number"
    )
  }
  if (mcmc_chainlength <= 0) {
    stop("alignment_to_beast_posterior: ",
      "mcmc_chainlength must non-zero and positive"
    )
  }
  if (!is.character(base_filename)) {
    stop("alignment_to_beast_posterior: ",
      "base_filename must be a character string"
    )
  }
  if (!is_whole_number(rng_seed)) {
    stop("alignment_to_beast_posterior: ",
      "rng_seed must be a whole number"
    )
  }
  if (!is.null(beast_jar_path) && !is.character(beast_jar_path)) {
    stop("alignment_to_beast_posterior: ",
      "beast_jar_path must be NULL or a character string"
    )
  }
  if (!file.exists(beast_jar_path)) {
    stop("alignment_to_beast_posterior: ",
      "beast_jar_path not found"
    )
  }
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "alignment_to_beast_posterior: ",
      "verbose should be TRUE or FALSE"
    )
  }

  # File paths
  beast_filename <- paste0(base_filename, ".xml")

  beast_log_filename <- paste0(base_filename, ".log")
  beast_trees_filename <- paste0(base_filename, ".trees")
  beast_state_filename <- paste0(base_filename, ".xml.state")
  temp_fasta_filename <- paste0(base_filename, ".fasta")

  # Use the posterior already present?
  if (skip_if_output_present &&
    file.exists(beast_trees_filename) &&
    file.exists(beast_log_filename) &&
    file.exists(beast_state_filename)) {
    posterior <- rBEAST::beast2out.read.trees(beast_trees_filename)
    testit::assert(Cer2016::is_posterior(posterior))
    return(posterior)
  }

  # Create a BEAST2 XML input file
  alignment_to_beast_input_file(
    alignment_dnabin = alignment_dnabin,
    mcmc_chainlength = mcmc_chainlength,
    rng_seed = rng_seed,
    beast_filename = beast_filename,
    temp_fasta_filename = temp_fasta_filename,
    verbose = verbose
  )
  testit::assert(file.exists(beast_filename))

  # Run BEAST2, needs the BEAST2 .XML parameter file
  cmd <- paste0(
    "java -jar ", beast_jar_path,
    " -seed ", rng_seed,
    " -threads 8 -beagle",
    " -statefile ", beast_state_filename,
    " -overwrite ",
    " ", beast_filename # XML filename should always be last
  )

  cmd <- paste0(cmd, " 1>>testthat.log 2>>testthat.log")
  system(cmd)

  has_error <- FALSE
  # cat all errors
  if (!file.exists(beast_trees_filename)) {
    has_error <- TRUE
    cat(
      paste0("alignment_to_beast_posterior: ",
      "file '", beast_trees_filename, "' should have been created\n"),
      file = "testthat.log", append = TRUE
    )
  }
  if (!file.exists(beast_log_filename)) {
    has_error <- TRUE
    cat(
      paste0("alignment_to_beast_posterior: ",
      "file '", beast_log_filename, "' should have been created\n"),
      file = "testthat.log", append = TRUE
    )
  }
  if (!file.exists(beast_state_filename)) {
    has_error <- TRUE
    cat(
      paste0("alignment_to_beast_posterior: ",
      "file '", beast_state_filename, "' should have been created\n"),
      file = "testthat.log", append = TRUE
    )
  }
  if (has_error) {
    cat(
      paste0("alignment_to_beast_posterior: cmd :", cmd, "\n"),
      file = "testthat.log", append = TRUE
    )
    cmd <- paste0(
      "java -jar ", beast_jar_path,
      " -seed ", rng_seed,
      " -threads 8 -beagle",
      " -statefile ", beast_state_filename,
      " -overwrite ",
      " ", beast_filename, # XML filename should always be last
      " >> testthat.log"
    )
    system(cmd)
  }

  # Stop on errors

  # beast_trees_filename is the only essential one
  if (!file.exists(beast_trees_filename)) {
    stop(
      "alignment_to_beast_posterior: ",
      "file '", beast_trees_filename, "' should have been created"
    )
  }
  if (!file.exists(beast_log_filename)) {
    stop(
      "alignment_to_beast_posterior: ",
      "file '", beast_log_filename, "' should have been created"
    )
  }
  if (!file.exists(beast_state_filename)) {
    stop(
      "alignment_to_beast_posterior: ",
      "file '", beast_state_filename, "' should have been created"
    )
  }
  posterior <- rBEAST::beast2out.read.trees(beast_trees_filename)

  file.remove(beast_filename)
  file.remove(beast_trees_filename)
  file.remove(beast_log_filename)
  file.remove(beast_state_filename)

  if (!Cer2016::is_posterior(x = posterior)) {
    Cer2016::is_posterior(x = posterior, verbose = TRUE)
    cat(stderr(),
      file = "testthat.log", append = TRUE
    )
    stop(
      "alignment_to_beast_posterior: ",
      "no posterior created"
    )
  }
  testit::assert(Cer2016::is_posterior(posterior))
  return(posterior)
}
