#' Plot
#' @param filename a file name
#' @return Nothing, but it does generate plots
#' @author Richel Bilderbeek
#' @export
plot_species_tree <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("plot_species_tree: invalid filename")
  }
  file <- Cer2016::read_file(filename)
  for (sti in 1:2) {
    graphics::plot(
      get_species_tree_by_index(file = file, sti = sti),
      main = "Species tree"
    )
  }
}
