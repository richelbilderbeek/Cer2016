#' Set an species_tree of a file
#' @param file A loaded parameter file
#' @param sti the index of the species_tree
#' @param species_tree an species_tree, may also be NA
#' @return the modified file
#' @export
#' @author Richel Bilderbeek
set_species_tree_by_index <- function(
  file,
  sti,
  species_tree
) {
  if (sti < 1) {
    stop("index must be at least 1")
  }
  if (sti > length(file$species_trees)) {
    stop("index must be less than number of species_trees") # nolint
  }
  file$species_trees[[sti]] <- list(species_tree)
  file
}
