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
    title <- NA
    if (sti == 1) title <- "Species tree (youngest)"
    if (sti == 2) title <- "Species tree (oldest)"
    phylogeny <- get_species_tree_by_index(file = file, sti = sti)
    testit::assert(is_phylogeny(phylogeny))
    ape::plot.phylo(
      phylogeny,
      main = title
    )
  }
}
