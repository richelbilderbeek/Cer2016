#' Calculates the Effective Sample Sizes
#' @param traces a dataframe with traces with removed burn-in
#' @param sample_interval the interval in timesteps between samples
#' @return the effective sample sizes
#' @export
#' @author Richel Bilderbeek
calc_esses <- function(traces, sample_interval) {
  if (!is.data.frame(traces)) {
    stop("calc_esses: traces must be a data.frame")
  }
  if (sample_interval < 1) {
    stop("calc_esses: sample interval must be at least one")
  }

  esses <- rep(NA, ncol(traces))

  for (i in seq_along(estimates)) {
    trace <- as.numeric(t(estimates[i]))
    esses[i] <- calc_ess(trace, sample_interval = sample_interval)
  }

  df <- traces[1, ]
  df[1,] <- esses
  testit::assert(nrow(df) == 1)
  testit::assert(names(df) == names(traces))
  df
}
