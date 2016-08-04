#' Removed the burn-in from a trace
#' @param trace the values
#' @param burn_in the fraction that needs to be removed, must be [0,1>
#' @return the values with the burn-in removed
#' @export
#' @examples
#'   # Create a trace from one to and including ten
#'   v <- seq(1, 10)
#'
#'   # Remove the first ten percent of its values,
#'   # in this case removes the first value, which is one
#'   w <- remove_burn_in(trace = v, burn_in = 0.1)
#'
#'   # Check that the result goes from two to ten
#'   testit::assert(w == seq(2, 10))
#' @author Richel Bilderbeek
remove_burn_in <- function(trace, burn_in) {
  if (!is.numeric(trace)) {
    stop("remove_burn_in: trace must be numeric")
  }
  if (burn_in < 0.0) {
    stop("remove_burn_in: burn_in must be at least zero")
  }
  if (burn_in > 1.0) {
    stop("remove_burn_in: burn_in must be at most one")
  }
  n <- length(trace)
  first_index <- as.integer(1 + (n * burn_in))
  if (first_index >= length(trace)) {
    return(c())
  }
  out <- trace[ seq(first_index, n) ]
  out
}

