#' Run the full simulation pipeline on a parameter file
#' @param filename name of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing. It does modify the input filename
#' @export
#' @author Richel Bilderbeek
do_simulation <- function(
  filename,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "do_simulation: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (length(filename) != 1) {
    stop("do_simulation: supply exactly one parameter filename")
  }
  if (!is_valid_file(filename)) {
    stop("do_simulation: filename must be a valid file")
  }
  add_pbd_output(filename, verbose = verbose)
  add_species_trees(filename, verbose = verbose)
  add_alignments(filename, verbose = verbose)
  add_posteriors(filename, verbose = verbose)
}
