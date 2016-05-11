#' Read a .RDA file
#' @param filename name of the file
#' @return the file as R data
#' @export
#' @author Richel Bilderbeek
read_file <- function(filename) {
  if (length(filename) != 1) {
    stop("read_file: must supply 'read_file' with one filename")
  }
  if (!file.exists(filename)) {
    stop("read_file: file '", filename, "' does not exist")
  }
  if (!is_valid_file(filename)) {
    stop("read_file: file '", filename, "'not exist' is invalid")
  }
  file <- readRDS(filename)
  file
}
