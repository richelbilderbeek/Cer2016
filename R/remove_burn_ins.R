#' Removed the burn-ins from a data frame
#' @param traces a data frame with traces
#' @param burn_in the fraction that needs to be removed, must be [0,1>
#' @return the data frame with the burn-in removed
#' @export
#' @author Richel Bilderbeek
remove_burn_ins <- function(traces, burn_in) {
  if (!is.data.frame(traces)) {
    stop("remove_burn_ins: traces must be a data.frame")
  }
  if (burn_in < 0.0) {
    stop("remove_burn_ins: burn_in must be at least zero")
  }
  if (burn_in > 1.0) {
    stop("remove_burn_ins: burn_in must be at most one")
  }
  n <- length(trace)
  first_index <- as.integer(1 + (n * burn_in))
  if (first_index >= length(trace)) {
    return(c())
  }
  out <- traces[ seq(first_index, n), ]
  out
}

