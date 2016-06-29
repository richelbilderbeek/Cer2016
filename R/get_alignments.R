#' Extract the alignments
#'   from a file
#' @param file A loaded parameter file
#' @return all alignments
#' @export
#' @author Richel Bilderbeek
get_alignments <- function(file) {
  return(file$alignments)
}
