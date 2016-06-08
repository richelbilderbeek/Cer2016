#' Plot a random posterior phylogeny
#' @param filename a filename
#' @return Nothing, but it does generate some plots
#' @author Richel Bilderbeek
#' @export
plot_posterior_samples <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("plot_posterior_samples: invalid filename")
  }
  base_filename <- tools::file_path_sans_ext(filename)
  file <- Cer2016::read_file(filename)
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
  index <- 1
  for (i in seq(1, n_species_trees_samples)) {
    for (j in seq(1, n_alignments)) {
      for (k in seq(1, n_beast_runs)) {
        all_trees <- Cer2016::extract_posteriors(file)[[index]][[1]]
        n_trees <- length(all_trees)
        random_tree_index <- round(runif(1, min = 1, max = n_trees))
        random_tree <- all_trees[[random_tree_index]]
        graphics::plot(random_tree, main = paste(base_filename,
          "random tree in posterior", i, j, k)
        )
        index <- index + 1
      }
    }
  }
}
