#' Run the full simulation pipeline on the test parameters
#' @param filenames the name of the four files created
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing. It creates the four files
#' @export
#' @author Richel Bilderbeek
do_test_simulations <- function(
  filenames = paste0("toy_example_", seq(1, 4), ".RDa"),
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop("verbose should be TRUE or FALSE")
  }
  if (length(filenames) != 4) {
    stop(
      "must have exactly four filenames"
    )
  }
  Cer2016::create_test_parameter_files(
    filenames = filenames
  )
  for (filename in filenames) {
    Cer2016::add_pbd_output(filename, verbose = verbose)
    Cer2016::add_species_trees(filename)
    Cer2016::add_alignments(filename)
    Cer2016::add_posteriors(
      filename = filename,
      skip_if_output_present = TRUE,
      verbose = verbose
    )
  }
}
