#' Collect the number of posteriors in a parameter file
#' @param filename name of the file containing the parameters and results
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return a data frame
#' @examples
#'  filename <- find_path("toy_example_3.RDa")
#'  df <- collect_n_posteriors(filename)
#'  testit::assert(names(df) == c("n_posteriors"))
#'  testit::assert(ncol(df) == 1)
#'  testit::assert(nrow(df) == 1)
#'  testit::assert(df$n_posteriors[1] == 8)
#' @export
#' @author Richel Bilderbeek
collect_n_posteriors <- function(
  filename,
  verbose = FALSE
) {
  # Order dependency: check verbose first,
  # otherwise is_valid_file will stop
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_n_posteriors: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename = filename, verbose = verbose)) {
    stop(
      "collect_n_posteriors: ",
      "invalid filename '", filename, "'"
    )
  }

  file <- Cer2016::read_file(filename)
  n <- sum(!is.na(file$posteriors))
  return (data.frame(n_posteriors = n))
}
