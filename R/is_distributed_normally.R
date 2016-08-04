#' Sees if the values of a distribution are normally distributed
#'  using a Shapiro-Wilk normality test
#' @param values the values to check
#' @param p_value the p value
#' @return TRUE when it cannot be rejected that the distribution is normal,
#'    FALSE when it can be rejected that the distribution is normal,
#'    NA when all values have been identical. The function will call
#'    stop if not all values are numeric or the number of values
#'    is not between three and five thousand
#' @examples
#'
#'    # Set a random number generator seed for reproducible results
#'    set.seed(42)
#'
#'    # Create a normal distribution
#'    nd <- rnorm(n = 1000, mean = 0.0, sd = 1.0)
#'    # The normal distribution should be normal
#'    testit::assert(is_distributed_normally(nd))
#'
#'    # Create a non-normal distribution
#'    nnd <- runif(n = 1000, min = 0.0, max = 1.0)
#'    # The non-normal distribution should not be normal
#'    testit::assert(!is_distributed_normally(nnd))
#'
#'    # Create a disribution of one value only
#'    r <- rep(x = 42, times = 100)
#'    # This one-value distribution should return NA
#'    testit::assert(is.na(is_distributed_normally(r)))
#'
#' @export
#' @author Richel Bilderbeek
is_distributed_normally <- function(
  values,
  p_value = 0.05
) {
  if (any(is.na(values)) || any(!is.numeric(values))) {
    stop("is_distributed_normally: all values must be numeric")
  }
  if (length(values) < 3L || length(values) > 5000L) {
    stop("is_distributed_normally: sample size must be between 3 and 5000")
  }
  if (all(values == values[1])) {
    # all values are identical
    return (NA)
  }
  t <- stats::shapiro.test(x = values)
  if (t$p >= p_value) {
    # Cannot reject distribution is normal
    return (TRUE)
  }
  if (t$p < 0.05) {
    # Reject distribution is normal
    return (FALSE)
  }
}
