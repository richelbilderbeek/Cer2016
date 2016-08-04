#' Calculates the Effective Sample Size
#' @param trace the values without burn-in
#' @param sample_interval the interval in timesteps between samples
#' @return the effective sample size
#' @export
#' @author Richel Bilderbeek
calc_ess <- function(trace, sample_interval) {
  act <- calc_act(trace = trace, sample_interval = sample_interval)
  ess <- length(trace) / (act / sample_interval)
  ess
}
