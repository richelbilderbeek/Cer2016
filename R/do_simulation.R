#' Run the full simulation pipeline on a parameter file on a local computer.
#' @param filename name of the parameter file
#' @param cache_beast_output if the BEAST2 output files exist, do not recalculate
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing. It does modify the input filename
#' @export
#' @author Richel Bilderbeek
do_simulation <- function(
  filename,
  cache_beast_output = FALSE,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop("verbose should be TRUE or FALSE")
  }
  if (length(filename) != 1) {
    stop("supply exactly one parameter filename")
  }
  if (!is_valid_file(filename)) {
    stop("filename must be a valid file")
  }
  Cer2016::add_pbd_output(filename, verbose = verbose)
  Cer2016::add_species_trees(filename)
  Cer2016::add_alignments(filename)
  Cer2016::add_posteriors(
    filename = filename,
    skip_if_output_present = cache_beast_output,
    verbose = verbose
  )
}
