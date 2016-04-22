#' Add a species tree with outgroup to a file
#' @param filename Parameter filename
#' @return Nothing, modifies the parameter file
#' @export
#' @author Richel Bilderbeek
add_species_trees_with_outgroup <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("add_species_trees_with_outgroup: invalid file")
  }
  file <- read_file(filename)
  if (is.na(file$pbd_output[1])) {
    stop("add_species_trees_with_outgroup: ",
      "file ", filename, " needs a pbd_output"
    )
  }
  parameters <- file$parameters
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])
  rng_seed <- as.numeric(parameters$rng_seed[2])
  print(paste("Adding species_trees_with_outgroup to file ",
    filename, sep = "")
  )

  for (i in seq(1:n_species_trees_samples)) {
    if (!is.na(file$species_trees_with_outgroup[i])) {
      print(paste(" * species_trees_with_outgroup[", i, "] already exists",
        sep = "")
      )
      next
    }
    print(paste("   * Setting seed to ", (rng_seed + i), sep = ""))
    # Each species tree is generated from its own RNG seed
    set.seed(rng_seed + i)
    species_tree <- sample_species_trees_from_pbd_sim_output(
      n = 1, file$pbd_output
    )[[1]]
    species_tree_with_outgroup <- add_outgroup_to_phylogeny(
      species_tree, stem_length = 0
    )
    testit::assert(class(species_tree_with_outgroup) == "phylo")
    file$species_trees_with_outgroup[[i]] <- list(species_tree_with_outgroup)
    saveRDS(file, file = filename)
  }
  print(paste("Added species_trees_with_outgroup to file ", filename, sep = ""))
}