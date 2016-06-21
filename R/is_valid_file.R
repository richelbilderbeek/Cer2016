#' Checks if a file is a valid parameter file
#' @param filename the name of the file to be checked
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return TRUE or FALSE
#' @examples
#'   testit::assert(is_valid_file(find_path("toy_example_1.RDa")))
#' @author Richel Bilderbeek
#' @export
is_valid_file <- function(
  filename,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "is_valid_file: verbose should be TRUE or FALSE"
    )
  }
  if (!file.exists(filename)) {
    if (verbose) {
      message(
        "is_valid_file: file '", filename, "' not found"
      )
    }
    return(FALSE)
  }
  file <- NULL
  tryCatch(
    file <- Cer2016::read_file(filename),
    error = function(msg) {
      if (verbose) message(msg)
    }
  )
  if (is.null(file)) return(FALSE)
  if (mode(file) != "list") {
    if (verbose) message("is_valid_file: file must be a list")
    return(FALSE)
  }
  if (is.null(file$parameters)) {
    if (verbose) message("is_valid_file: file$parameters absent")
    return(FALSE)
  }
  if (is.null(file$pbd_output)) {
    if (verbose) message("is_valid_file: file$pbd_output absent")
    return(FALSE)
  }
  if (is.null(file$species_trees_with_outgroup)) {
    if (verbose) message("is_valid_file: file$species_trees_with_outgroup absent")
    return(FALSE)
  }
  if (is.null(file$alignments)) {
    if (verbose) message("is_valid_file: file$alignments absent")
    return(FALSE)
  }
  if (is.null(file$posteriors)) {
    if (verbose) message("is_valid_file: file$posteriors absent")
    return(FALSE)
  }

  # First try if parameters can be read
  success <- NA
  tryCatch(
    success <- extract_erg(file),
    error = function(msg) {
      if (verbose) message(msg)
    }
  )
  if (is.na(success)) return (FALSE)
  tryCatch(
    success <- extract_eri(file),
    error = function(msg) {
      if (verbose) message(msg)
    }
  )
  if (is.na(success)) return (FALSE)
  tryCatch(
    success <- extract_scr(file),
    error = function(msg) {
      if (verbose) message(msg)
    }
  )
  if (is.na(success)) return (FALSE)
  tryCatch(
    success <- extract_sirg(file),
    error = function(msg) {
      if (verbose) message(msg)
    }
  )
  if (is.na(success)) return (FALSE)
  tryCatch(
    success <- extract_siri(file),
    error = function(msg) {
      if (verbose) message(msg)
    }
  )
  if (is.na(success)) return (FALSE)


  # Actually reading the parameters
  parameters <- file$parameters
  if (extract_erg(file) < 0.0) {
    if (verbose) message("is_valid_file: ERG invalid")
    return(FALSE)
  }
  if (Cer2016::extract_eri(file) < 0.0) {
    if (verbose) message("is_valid_file: ERI invalid")
    return(FALSE)
  }
  if (Cer2016::extract_scr(file) < 0.0) {
    if (verbose) message("is_valid_file: SCR invalid")
    return(FALSE)
  }
  if (Cer2016::extract_sirg(file) < 0.0) {
    if (verbose) message("is_valid_file: SIRG invalid")
    return(FALSE)
  }
  if (Cer2016::extract_siri(file) < 0.0) {
    if (verbose) message("is_valid_file: SIRI invalid")
    return(FALSE)
  }
  if (!is.null(parameters$add_ougroup)) {
    if (verbose) message("is_valid_file: add_ougroup must be absent")
    return(FALSE)
  }

  if (as.numeric(parameters$age[2]) <= 0.0) {
    if (verbose) message("is_valid_file: age invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$n_species_trees_samples[2]) < 1) {
    if (verbose) message("is_valid_file: n_species_trees_samples invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$mutation_rate[2]) <= 0.0) {
    if (verbose) message("is_valid_file: mutation_rate invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$n_alignments[2]) < 1) {
    if (verbose) message("is_valid_file: n_alignments invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$sequence_length[2]) < 1) {
    if (verbose) message("is_valid_file: sequence_length invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$n_beast_runs[2]) < 1) {
    if (verbose) message("is_valid_file: n_beast_runs invalid")
    return(FALSE)
  }
  if (as.numeric(parameters$mcmc_chainlength[2]) < 1) {
    if (verbose) message("is_valid_file: mcmc_chainlength invalid")
    return(FALSE)
  }
  return(TRUE)
}
