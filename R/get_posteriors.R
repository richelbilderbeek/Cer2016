#' Extract the BEAST2 posterior phyogenies
#'   from a file
#' @param file A loaded parameter file
#' @return all posteriors
#' @export
#' @author Richel Bilderbeek
get_posteriors <- function(file) {
  return(file$posteriors)
}
