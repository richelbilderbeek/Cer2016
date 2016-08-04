#' Calculate the autocorrelation time
#' @param trace the values
#' @param sample_interval the interval in timesteps between samples
#' @return the autocorrelation time
#' @export
#' @seealso Java code can be found [here](https://github.com/CompEvol/beast2/blob/9f040ed0357c4b946ea276a481a4c654ad4fff36/src/beast/core/util/ESS.java#L161)
#' @author The original Java version of the algorithm was from Remco Bouckaert,
#'   ported to R and adapted by Richel Bilderbeek
calc_act <- function(trace, sample_interval) {
  # From https://github.com/CompEvol/beast2/blob/9f040ed0357c4b946ea276a481a4c654ad4fff36/src/beast/core/util/ESS.java#L48 # nolint
  max_lag <- 2000

  # sum of trace, excluding burn-in
  sum <- 0.0
  #  keep track of sums of trace(i)*trace(i_+ lag) for all lags, excluding burn-in
  squareLaggedSums <- rep(0.0, times = max_lag)
  autoCorrelation <- rep(0.0, times = max_lag)

  # Follow C zero-indexed loop
  for (i in seq(0, length(trace) - 1)) {
    sum <- sum + trace[i + 1] # +1 thanks to R's base-one arrays
    # calculate mean
    mean <- sum / (i + 1)

    # calculate auto correlation for selected lag times
    # sum1 = \sum_{start ... totalSamples-lag-1} trace
    sum1 <- sum
    # sum2 = \sum_{start+lag ... totalSamples-1} trace
    sum2 <- sum

    # Indices from 0
    for (lagIndex in seq(0, min(i + 1, max_lag) - 1)) {
      testit::assert(lagIndex + 1 >= 1)
      testit::assert(lagIndex + 1 <= length(squareLaggedSums))
      testit::assert(i + 1 >= 1)
      testit::assert(i + 1 <= length(trace))
      testit::assert(i - lagIndex + 1 >= 1)
      testit::assert(i - lagIndex + 1 <= length(trace))
      testit::assert(lagIndex + 1 <= length(trace))
      squareLaggedSums[lagIndex + 1] <- squareLaggedSums[lagIndex + 1] +
        trace[i - lagIndex + 1] * trace[i + 1]
      # The following line is the same approximation as in Tracer
      # (valid since mean *(samples - lag), sum1, and sum2 are approximately the same)
      # though a more accurate estimate would be
      # autoCorrelation[lag] = m_fSquareLaggedSums.get(lag) - sum1 * sum2
      testit::assert(lagIndex + 1 >= 1)
      testit::assert(lagIndex + 1 <= length(autoCorrelation))

      autoCorrelation[lagIndex + 1] <- squareLaggedSums[lagIndex + 1] - (sum1 + sum2) * mean + mean * mean * (i + 1 - lagIndex) # nolint
      testit::assert(i + 1 - lagIndex != 0)
      autoCorrelation[lagIndex + 1] <- autoCorrelation[lagIndex + 1] / (i + 1 - lagIndex) # nolint
      sum1 <- sum1 - trace[i - lagIndex + 1]
      sum2 <- sum2 - trace[lagIndex + 1]
    }
  }

  maxLag <- min(length(trace), max_lag)
  integralOfACFunctionTimes2 <- 0.0
  for (lagIndex in seq(0, maxLag - 1)) {
    if (lagIndex == 0) {
      integralOfACFunctionTimes2 <- autoCorrelation[0 + 1]
    } else if (lagIndex %% 2 == 0) {
      # fancy stopping criterion - see main comment in Tracer code of BEAST 1
      if (autoCorrelation[lagIndex - 1 + 1] + autoCorrelation[lagIndex + 1] > 0) {
        integralOfACFunctionTimes2 <- integralOfACFunctionTimes2 + (2.0 * (autoCorrelation[lagIndex - 1 + 1] + autoCorrelation[lagIndex + 1]))
      } else {
        break
      }
    }
  }

  # auto correlation time
  act <- sample_interval * integralOfACFunctionTimes2 / autoCorrelation[1]
  act
}
