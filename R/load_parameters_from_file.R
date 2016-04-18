#' Load parameters from file
#' @param filename name of the parameter file
#' @return a data frame with all parameters
#' @export
#' @author Richel Bilderbeek
load_parameters_from_file <- function(filename) {
  if (!file.exists(filename)) {
    stop("load_parameters_from_file: file does not exist")
  }
  my_table <- readRDS(filename)
  my_table
}