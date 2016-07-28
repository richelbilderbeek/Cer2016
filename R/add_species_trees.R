#' Add a species tree with/without outgroup to a file
#' @param filename Parameter filename
#' @return Nothing, modifies the parameter file
#' @export
#' @author Richel Bilderbeek
add_species_trees <- function(filename) {

  if (!is_valid_file(filename)) {
    stop("add_species_trees: invalid file")
  }
  file <- Cer2016::read_file(filename)
  if (is.na(file$pbd_output[1])) {
    stop("add_species_trees: ",
      "file '", filename, "' needs a pbd_output"
    )
  }

  file <- set_species_tree_by_index(
    file = file, sti = 1, species_tree = file$pbd_output$stree_youngest
  )
  file <- set_species_tree_by_index(
    file = file, sti = 2, species_tree = file$pbd_output$stree_oldest
  )
  saveRDS(file, file = filename)
}
