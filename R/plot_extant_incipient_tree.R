#' Plot the extant inicipient species tree
#' @param filename name of the parameter file
#' @return Nothing. It does produce a plot
#' @export
#' @author Richel Bilderbeek
plot_extant_incipient_tree <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("plot_extant_incipient_tree: ",
      "file '", filename, "' is invalid"
    )
  }
  base_filename <- basename(filename)
  file <- read_file(filename)
  graphics::plot(file$pbd_output[[1]], main = paste(
    base_filename, " gene tree", sep = "")
  )
}
