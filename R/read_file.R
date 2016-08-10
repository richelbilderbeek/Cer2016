#' Read a parameter (.RDa) file
#' @param filename name of the parameter (.RDa) file
#' @return the file as R data
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   print(names(file))
#' @author Richel Bilderbeek
read_file <- function(filename) {
  if (length(filename) != 1) {
    stop("must supply 'read_file' with one filename")
  }
  if (!file.exists(filename)) {
    stop("file '", filename, "' does not exist")
  }
  # Do not do  'if (!is_valid_file(filename)) {}',
  # as 'is_valid_file will call 'read_file', resulting
  # in an infinite recursion
  file <- NULL
  tryCatch(
    file <- readRDS(filename),
    error = function(msg) {
      stop(
        "read_file: ",
        "error in readRDS of file with name '",
        filename,
        "', with message '",
        msg,
        "'"
      )
    }
  )
  return(file)
}
