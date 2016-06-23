#' Run the full simulation pipeline on the test parameters
#' @param filename name of the parameter file
#' @param cache_beast_output if the BEAST2 output files exist, do not recalculate
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing. It does modify the input filename
#' @export
#' @author Richel Bilderbeek
do_test_simulations <- function(
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop("do_simulation: verbose should be TRUE or FALSE")
  }
  filenames <- Cer2016::create_test_parameter_files()
  for (filename in filenames) {
    Cer2016::add_pbd_output(filename, verbose = verbose)
    Cer2016::add_species_trees(filename, verbose = verbose)
    Cer2016::add_alignments(filename, verbose = verbose)
    Cer2016::add_posteriors(
      filename = filename,
      skip_if_output_present = TRUE,
      verbose = verbose
    )
  }
}
