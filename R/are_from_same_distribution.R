#' Checks if two samples are from the same distribution
#' with a Mann-Whitney U test
#' @param a samples
#' @param b samples
#' @param alpha significance level, is 0.05 by default
#' @return TRUE or FALSE, or NA if cannot be calculated
#' @export
are_from_same_distribution <- function(a, b, alpha = 0.05) {
  if (length(a) == 0 || length(b) == 0) {
    return (NA)
  }

  t <- NA
  tryCatch(
    t <- stats::wilcox.test(
        x = a,
        y = b,
        correct = FALSE,
        exact = FALSE # cannot compute exact p-value with ties
      ),
    error = function(msg) {
      print(paste("are_from_same_distribution:", msg))
    }
  )
  if (length(t) > 1 || !is.na(t)) {
    return (t$p.value > alpha)
  }
  return (NA)
}
