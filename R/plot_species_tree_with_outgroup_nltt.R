#' Plot species_tree_with_outgroup_nltt
#' @param filename parameter filename
#' @param dt the resolution of the nLTT plot,
#'   must be in range <0,1>, default is 0.001
#' @author Richel Bilderbeek
#' @export
plot_species_tree_with_outgroup_nltt <- function(
  filename,
  dt = 0.001
) {
  testit::assert(is_valid_file(filename))

  nltt_values <- collect_species_tree_nltts(
    filename, dt)

  ggplot2::ggplot(
    data = nltt_values,
    ggplot2::aes(t, nltt),
    main = "Species tree(s)"
  ) + ggplot2::geom_point(
    color = "transparent"
  ) + ggplot2::scale_x_continuous(
    limits = c(0, 1)
  ) + ggplot2::scale_y_continuous(
    limits = c(0, 1)
  ) + ggplot2::stat_summary(
    fun.data = "mean_cl_boot", size = 0.5,
    color = I("black"), geom = "smooth"
  )
}
