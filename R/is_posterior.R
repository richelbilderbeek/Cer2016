#' Determines if the input is a BEAST2 posterior
#' @param x the input
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return TRUE or FALSE
#' @author Richel Bilderbeek
#' @export
is_posterior <- function(
  x,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "is_posterior: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (class(x) != "list") {
    if (verbose) {
      message("x is not a list")
    }
    return(FALSE)
  }

  return(TRUE)
}
