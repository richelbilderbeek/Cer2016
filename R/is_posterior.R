#' Determines if the input is a BEAST2 posterior
#' @param x the input
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return TRUE or FALSE
#' @examples
#'
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   posterior <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
#'   testit::assert(is_posterior(posterior))
#'
#' @author Richel Bilderbeek
#' @export
is_posterior <- function(
  x,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "is_posterior: verbose should be TRUE or FALSE"
    )
  }
  if (class(x) != "list") {
    if (verbose) {
      message("is_posterior: x is not a list")
    }
    return(FALSE)
  }

  return(TRUE)
}
