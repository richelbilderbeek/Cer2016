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

  # Sampled species tree nLTT values
  # stub
  true_nltt_values <- ribir::get_nltt_values(list(ape::rcoal(10)), dt = dt)

  # Posterior nLTT values
  nltt_values <- NA

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
        these_nltt_values <- ribir::get_nltt_values(phylogenies, dt = dt)
        if (is.na(these_nltt_values)) {
          nltt_values <- these_nltt_values
        } else {
          nltt_values <- rbind(nltt_values, these_nltt_values)
        }
      }
    }
  }


  ggplot2::ggplot(
    data = nltt_values,
    ggplot2::aes(t, nltt),
    main = "nLTT plots"
  ) + ggplot2::geom_step(
    data = true_nltt_values,
    ggplot2::aes(t, nltt)
  ) + ggplot2::geom_point(
    color = "transparent"
  ) + ggplot2::scale_x_continuous(
    limits = c(0, 1)
  ) + ggplot2::scale_y_continuous(
    limits = c(0, 1)
  ) + ggplot2::stat_summary(
    fun.data = "mean_cl_boot", size = 0.5, lty = "dashed",
    color = I("black"), geom = "smooth"
  ) + ggplot2::geom_step(
    data = true_nltt_values,
    ggplot2::aes(t, nltt)
  )
}
