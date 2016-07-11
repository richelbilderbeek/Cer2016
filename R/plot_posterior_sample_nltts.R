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
  if (!is_valid_file(filename)) {
    stop("plot_posterior_sample_nltts: invalid filename")
  }
  nltt <- NULL; rm(nltt) # nolint, should fix warning: plot_posterior_sample_nltts: no visible binding for global variable ‘nltt’

  file <- Cer2016::read_file(filename)
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])

  # Sampled species tree nLTT values
  true_nltt_values <- NULL

  for (sti in 1:2) {
    nltt_values <- nLTT::get_nltt_values(
      list(get_species_tree_by_index(file = file, sti = sti)),
      dt = dt
    )
    if (is.null(true_nltt_values)) {
      true_nltt_values <- nltt_values
    } else {
      true_nltt_values <- rbind(true_nltt_values, nltt_values)
    }
  }

  # Posterior nLTT values
  nltt_values <- NULL
  index <- 1

  for (sti in seq(1, 2)) {
    for (j in seq(1, n_alignments)) {
      for (k in seq(1, n_beast_runs)) {
        all_trees <- Cer2016::get_posteriors(file)[[index]][[1]]
        n_trees <- length(all_trees)
        random_tree_index <- round(stats::runif(1, min = 1, max = n_trees))
        random_tree <- all_trees[[random_tree_index]]
        these_nltt_values <- nLTT::get_nltt_values(
          list(random_tree),
          dt = dt
        )

        if (is.null(nltt_values)) {
          nltt_values <- these_nltt_values
        } else {
          nltt_values <- rbind(nltt_values, these_nltt_values)
        }
        index <- index + 1
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
