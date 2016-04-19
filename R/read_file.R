#' Read a .RDA file
#' @param filename name of the file
#' @return the file as R data
#' @export
read_file <- function(filename) {
  if (!file.exists(filename)) {
    stop("read_file: file does not exist")
  }
  file <- readRDS(filename)
  file
}
