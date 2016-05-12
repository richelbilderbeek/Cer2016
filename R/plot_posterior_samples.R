#' Plot a random posterior phylogeny
#' @param filename a filename
#' @return Nothing, but it does generate some plots
#' @export
#' @author Richel Bilderbeek
plot_posterior_samples <- function(filename) {
  testit::assert(is_valid_file(filename))
  base_filename <- tools::file_path_sans_ext(basename(filename))
  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
  for (i in seq(1, n_species_trees_samples)) {
    for (j in seq(1, n_alignments)) {
      for (k in seq(1, n_beast_runs)) {
        trees_filename <- paste(
          base_filename, "_", i, "_", j, "_", k, ".trees", sep = ""
        )
        if (!file.exists(trees_filename)) {
          print(paste("File '", trees_filename, "' not found", sep = ""))
          next
        }
        all_trees <- rBEAST::beast2out.read.trees(trees_filename)
        n_trees <- length(all_trees)
        random_tree_index <- round(runif(1, min = 1, max = n_trees))
        random_tree <- all_trees[[random_tree_index]]
        plot(random_tree, main = paste(base_filename,
          "random tree in posterior", i, j, k)
        )
      }
    }
  }
}
