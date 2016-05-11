#' Collect the gamma statistics of the BEAST2 posteriors
#' @param filename name of the file containing the parameters and results
#' @return a data frame
#' @export
#' @author Richel Bilderbeek
collect_posterior_gammas <- function(filename) {
  if (!is_valid_file(filename)) {
    stop(
      "collect_posterior_gammas: ",
      "invalid filename"
    )
  }
  file <- read_file(filename)
  parameters <- file$parameters
  n_alignments <- as.numeric(parameters$n_alignments[2])
  n_beast_runs <- as.numeric(parameters$n_beast_runs[2])
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )

  df <- NULL

  for (i in seq(1, n_species_trees_samples)) {
    for (j in seq(1, n_alignments)) {
      for (k in seq(1, n_beast_runs)) {
        base_filename <- paste(basename(
          tools::file_path_sans_ext(filename)), "_",
          i, "_", j, "_", k, sep = ""
        )
        trees_filename <- paste(base_filename, ".trees", sep = "")
        if (!file.exists(trees_filename)){
          stop(
            "plot_posterior_nltts:",
            "cannot find file '",
            trees_filename, "'"
          )
        }
        phylogenies <- rBEAST::beast2out.read.trees(trees_filename)
        gamma_statistics <- collect_gamma_statistics(phylogenies)

        # Remove id column
        gamma_statistics <- subset(
          gamma_statistics,
          select = -c(id) # nolint Putting 'gamma_statistics$' before ID will break the code
        )
        testit::assert(!is.null(gamma_statistics$gamma))

        n_gamma_statistics <- nrow(gamma_statistics)
        this_df <- data.frame(
          species_tree = rep(i, n_gamma_statistics),
          alignment = rep(j, n_gamma_statistics),
          beast_run = rep(k, n_gamma_statistics)
        )
        this_df <- cbind(this_df, gamma_statistics)
        if (is.na(df)) {
          df <- this_df
        } else {
          df <- rbind(df, this_df)
        }
      }
    }
  }
  testit::assert(!is.null(df$gamma))
  df
}