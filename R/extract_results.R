#' Extract the BEAST2 posterior phyogenies
#'   from a file
#' @param file A loaded parameter file
#' @return the value of the ERG parameter
#' @export
#' @author Richel Bilderbeek
extract_posteriors <- function(file) {
  return(file$posteriors)
}
