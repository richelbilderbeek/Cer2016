#' Plot species_tree_with_outgroup_nltt
#' @param filename parameter filename
plot_species_tree_with_outgroup_nltt <- function(filename) {
  testit::assert(is_valid_file(filename))
  base_filename <- basename(filename)
  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  for (i in seq(1, n_species_trees_samples)) {
    nLTT::nLTT.plot(file$species_trees_with_outgroup[[i]][[1]],
      main = paste(base_filename, "species tree with outgroup", i)
    )
  }
}
