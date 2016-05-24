#' Checks if a file is a valid parameter file
#' @param filename the name of the file to be checked
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return TRUE or FALSE
#' @export
#' @examples
#'   testit::assert(is_valid_file(find_path("toy_example_1.RDa")))
#'   testit::assert(!is_valid_file(find_path("toy_example_1_1_1_1.trees")))
#' @author Richel Bilderbeek
is_valid_file <- function(
  filename,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "is_valid_file: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!file.exists(filename)) {
    if (verbose) print(paste0("file '", filename, "'not found"))
    return(FALSE)
  }
  file <- NULL
  tryCatch(
    file <- Cer2016::read_file(filename),
    error = function(msg) {
      if (verbose) print(msg)
    }
  )
  if (is.null(file)) return(FALSE)
  if (mode(file) != "list") {
    if (verbose) print("file must be a list")
    return(FALSE)
  }
  if (is.null(file$parameters)) {
    if (verbose) print("file$parameters absent")
    return(FALSE)
  }
  if (is.null(file$pbd_output)) {
    if (verbose) print("file$pbd_output absent")
    return(FALSE)
  }
  if (is.null(file$species_trees_with_outgroup)) {
    if (verbose) print("file$species_trees_with_outgroup absent")
    return(FALSE)
  }
  if (is.null(file$alignments)) {
    if (verbose) print("file$alignments absent")
    return(FALSE)
  }
  if (is.null(file$posteriors)) {
    if (verbose) print("file$posteriors absent")
    return(FALSE)
  }
  parameters <- file$parameters
  if (Cer2016::extract_erg(file) < 0.0) {
    if (verbose) print("ERG invalid")
    return(FALSE)
  }
  if (Cer2016::extract_eri(file) < 0.0) {
    if (verbose) print("ERI invalid")
    return(FALSE)
  }
  if (Cer2016::extract_scr(file) < 0.0) {
    if (verbose) print("SCR invalid")
    return(FALSE)
  }
  if (Cer2016::extract_sirg(file) < 0.0) {
    if (verbose) print("SIRG invalid")
    return(FALSE)
  }
  if (Cer2016::extract_siri(file) < 0.0) {
    if (verbose) print("SIRI invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$age[2]) <= 0.0) {
    if (verbose) print("age invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$n_species_trees_samples[2]) < 1) {
    if (verbose) print("n_species_trees_samples invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$mutation_rate[2]) <= 0.0) {
    if (verbose) print("mutation_rate invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$n_alignments[2]) < 1) {
    if (verbose) print("n_alignments invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$sequence_length[2]) < 1) {
    if (verbose) print("sequence_length invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$n_beast_runs[2]) < 1) {
    if (verbose) print("n_beast_runs invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$mcmc_chainlength[2]) < 1) {
    if (verbose) print("mcmc_chainlength invalid")
    return(FALSE)
  }
  return(TRUE)
}
