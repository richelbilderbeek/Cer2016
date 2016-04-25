#' Plot the nLTTs of the posterior
#' @param filename a filename
#' @return Nothing, but it does generate some plots
#' @export
plot_posterior_sample_nltts <- function(filename) {
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
        trees_filename <- paste(base_filename,
          "_", i, "_", j, "_", k, ".trees", sep = ""
        )
        if (!file.exists(trees_filename)) {
          print(paste("File '", trees_filename, "' not found", sep = ""))
          next
        }
        all_trees <- rBEAST::beast2out.read.trees(trees_filename)
        last_tree <- tail(all_trees, n = 1)[[1]]
        nLTT::nLTT.plot(file$species_trees_with_outgroup[[1]][[1]],
          main = paste(base_filename, "species tree with outgroup nLTTs",
            i, j, k), lwd = 2
        )
        nLTT::nLTT.lines(last_tree, lwd = 2, lty = 3)
      }
    }
  }
}