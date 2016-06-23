#' Set a BEAST2 posterior of a file
#' @param file A loaded parameter file
#' @param posterior_index the index of the posterior
#' @param posterior a BEAST2 posterior, may also be NA
#' @return the modified file
#' @export
#' @author Richel Bilderbeek
set_posterior_by_index <- function(
  file,
  posterior_index,
  posterior
) {
  file$posteriors[[posterior_index]] <- list(posterior)
  file
}
