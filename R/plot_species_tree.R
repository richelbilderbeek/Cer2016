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
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  for (i in seq(1, n_species_trees_samples)) {
    graphics::plot(file$species_trees_with_outgroup[[i]][[1]],
      main = "Species tree"
    )
  }
}
