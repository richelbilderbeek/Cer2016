#' Checks if two samples are from the same distribution
#' with a Mann-Whitney U test
#' @param a samples
#' @param b samples
#' @param alpha significance level, is 0.05 by default
#' @return TRUE or FALSE
#' @export
are_from_same_distribution <- function(a, b, alpha = 0.05)
{
  return (wilcox.test(a, b, correct = FALSE)$.pvalue > 0.95)
}
