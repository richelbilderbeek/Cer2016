#' Plot the nLTTs of the posterior
#' @param filename a filename
#' @param dt the resolution of the nLTT plot,
#'   must be in range <0,1>, default is 0.001
#' @return Nothing, but it does generate some plots
#' @export
#' @author Richel Bilderbeek
plot_posterior_sample_nltts <- function(
  filename,
  dt = 0.001
) {
  testit::assert(is_valid_file(filename))
  base_filename <- tools::file_path_sans_ext(basename(filename))
  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])

  # Sampled species tree nLTT values
  true_nltt_values <- NA

  for (i in seq(1, n_species_trees_samples)) {
    nltt_values <- ribir::get_nltt_values(
      list(file$species_trees_with_outgroup[[i]][[1]]),
      dt = dt
    )
    if (is.na(true_nltt_values)) {
      true_nltt_values <- nltt_values
    } else {
      true_nltt_values <- rbind(true_nltt_values, nltt_values)
    }
  }

  # Posterior nLTT values
  nltt_values <- NA

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
  )
}