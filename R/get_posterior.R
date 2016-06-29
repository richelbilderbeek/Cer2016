#' Extract a BEAST2 posterior phyogenies
#'   from a file
#' @param file A loaded parameter file
#' @param posterior_index the index of the posterior
#' @return the posterior
#' @export
#' @author Richel Bilderbeek
get_posterior_by_index <- function(
  file,
  posterior_index
) {
  if (posterior_index < 1) {
    stop("get_posterior_by_index: index must be at least 1")
  }
  if (posterior_index > length(file$posteriors)) {
    stop("get_posterior_by_index: index must be less than number of posteriors")
  }
  posterior <- file$posteriors[[posterior_index]][[1]]
  if (!Cer2016::is_beast_posterior(posterior)) {
    # The posterior may not be added yet
    stop(
      "get_posterior_by_index: posterior absent at index ",
      posterior_index
    )
  }
  posterior
}
