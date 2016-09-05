#' Checks if a file is a valid parameter file
#' @param file a file that has been openened by read_file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return TRUE or FALSE
#' @examples
#'   testit::assert(
#'     file_has_valid_parameters(
#'       file = read_file(find_path("toy_example_1.RDa"))
#'     )
#'   )
#' @author Richel Bilderbeek
#' @export
file_has_valid_parameters <- function(
  file,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "file_has_valid_parameters: verbose should be TRUE or FALSE"
    )
  }
  parameters <- file$parameters
  if (extract_erg(file) < 0.0) {
    if (verbose) message("file_has_valid_parameters: ERG invalid")
    return(FALSE)
  }
  if (Cer2016::extract_eri(file) < 0.0) {
    if (verbose) message("file_has_valid_parameters: ERI invalid")
    return(FALSE)
  }
  if (Cer2016::extract_scr(file) < 0.0) {
    if (verbose) message("file_has_valid_parameters: SCR invalid")
    return(FALSE)
  }
  if (Cer2016::extract_sirg(file) < 0.0) {
    if (verbose) message("file_has_valid_parameters: SIRG invalid")
    return(FALSE)
  }
  if (Cer2016::extract_siri(file) < 0.0) {
    if (verbose) message("file_has_valid_parameters: SIRI invalid")
    return(FALSE)
  }
  if (!is.null(parameters$add_ougroup)) {
    if (verbose) message("file_has_valid_parameters: add_ougroup must be absent") # nolint
    return(FALSE)
  }

  if (as.numeric(parameters$age[2]) <= 0.0) {
    if (verbose) message("file_has_valid_parameters: age invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$mutation_rate[2]) <= 0.0) {
    if (verbose) message("file_has_valid_parameters: mutation_rate invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$n_alignments[2]) < 1) {
    if (verbose) message("file_has_valid_parameters: n_alignments invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$sequence_length[2]) < 1) {
    if (verbose) message("file_has_valid_parameters: sequence_length invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$n_beast_runs[2]) < 1) {
    if (verbose) message("file_has_valid_parameters: n_beast_runs invalid")
    return(FALSE)
  }
  if (Cer2016::extract_nspp(file) < 1) {
    if (verbose) message("file_has_valid_parameters: nspp invalid")
    return(FALSE)
  }
  return(TRUE)
}
