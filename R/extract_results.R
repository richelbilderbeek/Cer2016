#' Extract a BEAST2 posterior phyogenies
#'   from a file
#' @param file A loaded parameter file
#' @return the posterior
#' @export
#' @author Richel Bilderbeek
extract_posterior_by_index <- function(file) {

  return(file$posterior[[posterior_index]][[1]])
}

#' Extract the BEAST2 posterior phyogenies
#'   from a file
#' @param file A loaded parameter file
#' @return all posteriors
#' @export
#' @author Richel Bilderbeek
extract_posteriors <- function(file) {
  return(file$posteriors)
}
