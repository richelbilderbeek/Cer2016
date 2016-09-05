#' Add a species tree with/without outgroup to a file
#' @param filename Parameter filename
#' @return Nothing, modifies the parameter file
#' @examples
#'  # Create a parameter file
#'   filename <- "add_species_trees_example.RDa"
#'   save_parameters_to_file(
#'     rng_seed = 42,
#'     sirg = 0.5,
#'     siri = 0.5,
#'     scr = 0.5,
#'     erg = 0.5,
#'     eri = 0.5,
#'     age = 5,
#'     mutation_rate = 0.1,
#'     n_alignments = 1,
#'     sequence_length = 10,
#'     nspp = 10,
#'     n_beast_runs = 1,
#'     filename = filename
#'   )
#'
#'   # Simulate an incipient species tree
#'   add_pbd_output(filename)
#'
#'   # No species tree added yet
#'   testit::assert(is.na(read_file(filename)$species_trees[1]))
#'
#'   # Add the species trees
#'   add_species_trees(filename = filename)
#'
#'   # Now species tree is added
#'   testit::assert(!is.na(read_file(filename)$species_trees[1]))
#'
#' @export
#' @author Richel Bilderbeek
add_species_trees <- function(filename) {

  if (!is_valid_file(filename)) {
    stop("invalid file")
  }
  file <- Cer2016::read_file(filename)
  if (is.na(file$pbd_output[1])) {
    stop(
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
