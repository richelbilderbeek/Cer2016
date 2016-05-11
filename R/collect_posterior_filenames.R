#' Collect posterior filenames
#' @param filename Parameter filename
#' @return generates species tree files from the posterior
#' @export
#' @author Richel Bilderbeek, Jolien Gay
collect_posterior_filenames <- function(
  parameter_filename
) {
  testit::assert(is_valid_file(parameter_filename))
  base_filename <- tools::file_path_sans_ext(basename(filename))
  file <- read_file(parameter_filename)
  n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
  # Posterior nLTT values
  nltt_values <- NULL

  for (i in seq(1, n_species_trees_samples)) {
    for (j in seq(1, n_alignments)) {
      for (k in seq(1, n_beast_runs)) {
        trees_filename <- paste(base_filename,
                                "_", i, "_", j, "_", k, ".trees", sep = ""
        )
        if (!file.exists(trees_filename)) {
          print(paste("File '", trees_filename, "' not found", sep = ""))
          next
        }
        all_trees <- rBEAST::beast2out.read.trees(trees_filename)
        n_trees <- length(all_trees)
        random_tree_index <- round(runif(1, min = 1, max = n_trees))
        random_tree <- all_trees[[random_tree_index]]
        these_nltt_values <- ribir::get_nltt_values(
          list(random_tree),
          dt = dt
        )

        if (is.na(nltt_values)) {
          nltt_values <- these_nltt_values
        } else {
          nltt_values <- rbind(nltt_values, these_nltt_values)
        }
      }
    }
  }
  testit::assert(!is.null(nltt_values$nltt))
}
