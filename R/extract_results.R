#' Extract a BEAST2 posterior phyogenies
#'   from a file
#' @param file A loaded parameter file
#' @return the posterior
#' @export
#' @author Richel Bilderbeek
get_posterior_by_index <- function(file, posterior_index) {
  posterior <- file$posterior[[posterior_index]][[1]]
  testit::assert(Cer2016:::is_beast_posterior(posterior))
  posterior
}

#' Set a BEAST2 posterior of a file
#' @param file A loaded parameter file
#' @return the modified file
#' @export
#' @author Richel Bilderbeek
set_posterior_by_index <- function(my_file, posterior_index, posterior) {
  my_file$posterior[[posterior_index]] <- list(posterior)
  my_file
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
