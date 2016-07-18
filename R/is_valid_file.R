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
  if (is.null(file$species_trees)) {
    if (verbose) {
      message("is_valid_file: file$species_trees absent")
    }
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

  return(
    Cer2016::file_has_valid_parameters(
      file = file, verbose = verbose
    )
  )
}
