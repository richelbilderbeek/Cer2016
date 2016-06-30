#' Add a species tree with/without outgroup to a file
#' @param filename Parameter filename
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing, modifies the parameter file
#' @export
#' @author Richel Bilderbeek
add_species_trees <- function(
  filename,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "add_species_trees: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename)) {
    stop("add_species_trees: invalid file")
  }
  file <- Cer2016::read_file(filename)
  if (is.na(file$pbd_output[1])) {
    stop("add_species_trees: ",
      "file '", filename, "' needs a pbd_output"
    )
  }
  if (verbose) {
    message("Adding species_trees to file ", filename)
  }

  for (sti in 1:2) {
    species_tree <- NA
    tryCatch(
      species_tree <- get_species_tree_by_index(file = file, sti = sti),
      error = function(msg) {
        if (verbose) {
          message("add_species_trees: species_tree #", sti, " already exists")
        }
      }
    )
    if (!is.na(species_tree)) next
    if (sti == 1) species_tree <- file$pbd_output$stree_youngest
    if (sti == 2) species_tree <- file$pbd_output$stree_oldest
    testit::assert(class(species_tree) == "phylo")
    file <- set_species_tree_by_index(
      file = file, sti = sti, species_tree = species_tree
    )
    saveRDS(file, file = filename)
  }
  if (verbose) {
    message("Added species_trees to file ", filename)
  }
}
