#' Convert an alignment to a BEAST2 XML input file
#' @param alignment_dnabin The alignmnet
#' @param mcmc_chainlength The length of the MCMC chain BEAST2 will generate
#' @param base_filename The base of the filename (the part without the extension)
#' @param rng_seed The random number generator seed used by BEAST2
#' @param beast_bin_path Where the binary 'beast' can be found
#' @param beast_jar_path Where the jar 'beast.jar' can be found
#' @param skip_if_output_present skip if output files are present, else remove these and start a new BEAST2 run
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A BEAST2 posterior
#' @export
#' @author Richel Bilderbeek
alignment_to_beast_posterior <- function(
  alignment_dnabin,
  mcmc_chainlength,
  base_filename,
  rng_seed = 42,
  beast_bin_path = "", #find_beast_bin_path(),
  beast_jar_path = find_beast_jar_path(),
  skip_if_output_present = FALSE,
  verbose = TRUE
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
  if (!is.null(beast_bin_path) && !is.character(beast_bin_path)) {
    stop("alignment_to_beast_posterior: ",
      "beast_bin_path must be NULL or a character string"
    )
  }
  if (!is.null(beast_jar_path) && !is.character(beast_jar_path)) {
    stop("alignment_to_beast_posterior: ",
      "beast_jar_path must be NULL or a character string"
    )
  }
  if (!file.exists(beast_bin_path) && !file.exists(beast_jar_path)) {
    stop("alignment_to_beast_posterior: ",
      "both beast_bin_path and beast_jar_path not found"
    )
  }
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "alignment_to_beast_posterior: ",
      "verbose should be TRUE or FALSE"
    )
  }

  # File paths
  beast_filename <- paste(base_filename, ".xml", sep = "")

  beast_log_filename <- paste(base_filename, ".log", sep = "")
  beast_trees_filename <- paste(base_filename, ".trees", sep = "")
  beast_state_filename <- paste(base_filename, ".xml.state", sep = "")
  temp_fasta_filename <- paste(base_filename, ".fasta", sep = "")

  if (skip_if_output_present &&
    file.exists(beast_trees_filename) &&
    file.exists(beast_log_filename) &&
    file.exists(beast_state_filename)) {
    return()
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
  # Prevent BEAST prompting the user whether to overwrite the log file

  if (file.exists(beast_trees_filename)) {
    file.remove(beast_trees_filename)
    if (verbose) {
      print(paste("NOTE: removed '", beast_trees_filename, "'"), sep = "")
    }
  }
  if (file.exists(beast_log_filename)) {
    file.remove(beast_log_filename)
    if (verbose) {
      print(paste("NOTE: removed '", beast_log_filename, "'"), sep = "")
    }
  }
  if (file.exists(beast_state_filename)) {
    file.remove(beast_state_filename)
    if (verbose) {
      print(paste("NOTE: removed '", beast_state_filename, "'"), sep = "")
    }
  }
  testit::assert(!file.exists(beast_trees_filename))
  testit::assert(!file.exists(beast_log_filename))
  testit::assert(!file.exists(beast_state_filename))

  if (file.exists(beast_bin_path)) {
    print("Call BEAST2 binary from full file path")
    # This may result in the following error:
    #
    #   Invalid maximum heap size: -Xmx4g
    #   The specified size exceeds the maximum representable size.
    #   Error: Could not create the Java Virtual Machine.
    #   Error: A fatal exception has occurred. Program will exit.
    #
    # Therefore, there is another go below to call BEAST
    cmd <- paste(
      beast_bin_path,
      " -seed ", rng_seed,
      #" -beagle_instances 4 -threads 4",
      " ", beast_filename, # XML filename should always be last
      sep = ""
    )
    system(cmd)
    if (file.exists(beast_trees_filename)) {
      print("File created by beast binary (called by its full path)")
      testit::assert(file.exists(beast_trees_filename))
      testit::assert(file.exists(beast_log_filename))
      testit::assert(file.exists(beast_state_filename))

      # Read all trees from the BEAST2 posterior
      posterior <- rBEAST::beast2out.read.trees(beast_trees_filename)
      testit::assert(Cer2016::is_beast_posterior(posterior))
      return(posterior)
    }
  }

  if (file.exists(beast_jar_path)) {
    if (verbose) {
      print("Call BEAST2 jar by its full file path")
    }
    cmd <- paste0(
      "java -jar ", beast_jar_path,
      " -seed ", rng_seed,
      #" -beagle_instances 4 -threads 4",
      " ", beast_filename # XML filename should always be last
    )
    if (verbose == FALSE) {
      # Silence BEAST
      cmd <- paste0(cmd, " 1>/dev/null 2>/dev/null")
    }
    system(cmd)
    if (file.exists(beast_trees_filename)) {
      if (verbose) {
        print("File created by BEAST2 jar file")
      }
      testit::assert(file.exists(beast_trees_filename))
      testit::assert(file.exists(beast_log_filename))
      testit::assert(file.exists(beast_state_filename))

      # Read all trees from the BEAST2 posterior
      posterior <- rBEAST::beast2out.read.trees(beast_trees_filename)
      return(posterior)
    }
  }

}
