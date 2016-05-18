#' Collect the nLTT values of the BEAST2 posteriors
#' @param filename name of the file containing the parameters and results
#' @param dt the resolution of the nLTT plot,
#'   must be in range <0,1>, default is 0.001
#' @return a data frame
#' @export
#' @author Richel Bilderbeek
collect_posterior_nltts <- function(
  filename,
  dt = 0.001
) {
  if (!is_valid_file(filename)) {
    stop("collect_posterior_nltts: invalid filename")
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
        base_filename <- paste(
          tools::file_path_sans_ext(filename), "_",
          i, "_", j, "_", k, sep = ""
        )
        trees_filename <- paste(base_filename, ".trees", sep = "")
        if (!file.exists(trees_filename)) {
          stop(
            "plot_posterior_nltts:",
            "cannot find file '",
            trees_filename, "'"
          )
        }
        phylogenies <- rBEAST::beast2out.read.trees(trees_filename)
        nltt_values <- ribir::get_nltt_values(phylogenies, dt = dt)

        n_nltt_values <- nrow(nltt_values)
        this_df <- data.frame(
          species_tree = rep(i, n_nltt_values),
          alignment = rep(j, n_nltt_values),
          beast_run = rep(k, n_nltt_values)
        )
        this_df <- cbind(this_df, nltt_values)
        if (is.null(df)) {
          df <- this_df
        } else {
          df <- rbind(df, this_df)
        }
      }
    }
  }
  testit::assert(!is.null(df$nltt))
  testit::assert(names(df)
    ==  c("species_tree", "alignment", "beast_run", "id", "t", "nltt")
  )
  names(df) <- c("species_tree", "alignment", "beast_run", "state", "t", "nltt")
  df
}
