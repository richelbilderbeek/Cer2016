#' Plot multiple BEAST2 posteriors
#' @param filename name of the file containing the parameters and results
#' @param dt the resolution of the nLTT plot,
#'   must be in range <0,1>, default is 0.001
#' @return Nothing, produces a plot
#' @export
#' @author Richel Bilderbeek
plot_posterior_nltts <- function(
  filename,
  dt = 0.001
) {
  if (!is_valid_file(filename)) {
    stop("plot_posterior_nltts: invalid filename")
  }

  # Sampled species tree nLTT values
  true_nltt_values <- collect_species_tree_nltts(
    filename = filename, dt = dt
  )

  # Posterior nLTT values
  nltt_values <- collect_posterior_nltts(
    filename = filename, dt = dt
  )
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
