#' Plot multiple BEAST2 posteriors
#' @param filename name of the file containing the parameters and results
#' @return Nothing, produces a plot
#' @export
#' @author Richel Bilderbeek
plot_posterior_nltts <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("plot_posterior_nltts: invalid filename")
  }
  dt <- 0.001
  file <- read_file(filename)
  parameters <- file$parameters
  n_alignments <- as.numeric(parameters$n_alignments[2])
  n_beast_runs <- as.numeric(parameters$n_beast_runs[2])
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  df <- NA

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
        r <- ribir::get_nltt_values(phylogenies, dt = dt)
        if (is.na(df)) {
          df <- r
        } else {
          df <- rbind(df, r)
        }
      }
    }
  }
#   ggplot2::qplot(t, nltt, data = df, geom = "blank", ylim = c(0, 1),
#     main = "Average nLTT plot of phylogenies") +
#     ggplot2::stat_summary(
#       fun.data = "mean_cl_boot", color = "red", geom = "smooth"
#     )
  ggplot2::ggplot(
    data = df,
    aes(t, nltt),
    main = "Average nLTT plot of phylogenies"
  ) + geom_point(color = "blank") +
    scale_x_continuous(limits = c(0, 1)) +
    scale_y_continuous(limits = c(0, 1)) +
  ggplot2::stat_summary(
    fun.data = "mean_cl_boot", color = "red", geom = "smooth"
  )
}
