# From [here](https://github.com/CompEvol/beast2/blob/9f040ed0357c4b946ea276a481a4c654ad4fff36/src/beast/core/util/ESS.java#L161) I copied the auto-correlation function:
#
#  public static double ACT(Double[] trace, int sampleInterval) {
#         /** sum of trace, excluding burn-in **/
#         double sum = 0.0;
#         /** keep track of sums of trace(i)*trace(i_+ lag) for all lags, excluding burn-in  **/
#         double[] squareLaggedSums = new double[MAX_LAG];
#         double[] autoCorrelation = new double[MAX_LAG];
#         for (int i = 0; i < trace.length; i++) {
#             sum += trace[i];
#             // calculate mean
#             final double mean = sum / (i + 1);
#
#             // calculate auto correlation for selected lag times
#             // sum1 = \sum_{start ... totalSamples-lag-1} trace
#             double sum1 = sum;
#             // sum2 = \sum_{start+lag ... totalSamples-1} trace
#             double sum2 = sum;
#             for (int lagIndex = 0; lagIndex < Math.min(i + 1, MAX_LAG); lagIndex++) {
#                 squareLaggedSums[lagIndex] = squareLaggedSums[lagIndex] + trace[i - lagIndex] * trace[i];
#                 // The following line is the same approximation as in Tracer
#                 // (valid since mean *(samples - lag), sum1, and sum2 are approximately the same)
#                 // though a more accurate estimate would be
#                 // autoCorrelation[lag] = m_fSquareLaggedSums.get(lag) - sum1 * sum2
#                 autoCorrelation[lagIndex] = squareLaggedSums[lagIndex] - (sum1 + sum2) * mean + mean * mean * (i + 1 - lagIndex);
#                 autoCorrelation[lagIndex] /= (i + 1 - lagIndex);
#                 sum1 -= trace[i - lagIndex];
#                 sum2 -= trace[lagIndex];
#             }
#         }
#
#         final int maxLag = Math.min(trace.length, MAX_LAG);
#         double integralOfACFunctionTimes2 = 0.0;
#         for (int lagIndex = 0; lagIndex < maxLag; lagIndex++) //{
#             if (lagIndex == 0) //{
#                 integralOfACFunctionTimes2 = autoCorrelation[0];
#             else if (lagIndex % 2 == 0)
#                 // fancy stopping criterion - see main comment in Tracer code of BEAST 1
#                 if (autoCorrelation[lagIndex - 1] + autoCorrelation[lagIndex] > 0) //{
#                     integralOfACFunctionTimes2 += 2.0 * (autoCorrelation[lagIndex - 1] + autoCorrelation[lagIndex]);
#                 else
#                     // stop
#                     break;
#         //}
#         //}
#         //}
#
#         // auto correlation time
#         return sampleInterval * integralOfACFunctionTimes2 / autoCorrelation[0];
#     }
#' Calculate the autocorrelation time
#' @param trace the values
#' @param sampleInterval the interval in timesteps between samples
#' @return the autocorrelation time
#' @export
#' @author Richel Bilderbeek
calc_act <- function(trace, sampleInterval) {
  # From https://github.com/CompEvol/beast2/blob/9f040ed0357c4b946ea276a481a4c654ad4fff36/src/beast/core/util/ESS.java#L48 # nolint
  MAX_LAG <- 2000

  # sum of trace, excluding burn-in
  sum <- 0.0
  #  keep track of sums of trace(i)*trace(i_+ lag) for all lags, excluding burn-in
  squareLaggedSums <- rep(0.0, times = MAX_LAG)
  autoCorrelation <- rep(0.0, times = MAX_LAG)

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
    for (lagIndex in seq(0, min(i + 1, MAX_LAG) - 1)) {
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

  maxLag <- min(length(trace), MAX_LAG)
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
  act <- sampleInterval * integralOfACFunctionTimes2 / autoCorrelation[1]
  act
}

#' Calculates the Effective Sample Size
#' @param trace the values
#' @param sampleInterval the interval in timesteps between samples
#' @return the effective sample size
#' @export
#' @author Richel Bilderbeek
calc_ess <- function(trace, sampleInterval) {
  act <- calc_act(trace = trace, sampleInterval = sampleInterval)
  ess <- length(trace) / (act / sampleInterval)
  ess
}
