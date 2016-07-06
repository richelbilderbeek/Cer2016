#' Plot species_tree_with_outgroup_nltt
#' @param filename parameter filename
#' @param dt the resolution of the nLTT plot,
#'   must be in range <0,1>, default is 0.001
#' @author Richel Bilderbeek
#' @export
plot_species_tree_nltt <- function(
  filename,
  dt = 0.001
) {
  if (!is_valid_file(filename)) {
    stop("plot_species_tree_nltt: invalid filename")
  }
  nltt <- NULL; rm(nltt) # nolint, should fix warning: plot_species_tree_nltt: no visible binding for global variable ‘nltt’

  nltt_values <- collect_species_tree_nltts(
    filename = filename, dt = dt
  )


  ggplot2::ggplot(
    data = nltt_values,
    ggplot2::aes(
      x = nltt_values$t,
      y = nltt_values$nltt,
      colour = nltt_values$species_tree
    ),
    main = "Species trees"
  ) + ggplot2::geom_step(direction = "vh"
  ) + ggplot2::scale_x_continuous(
    limits = c(0, 1)
  ) + ggplot2::scale_y_continuous(
    limits = c(0, 1)
  ) + ggplot2::ggtitle("Species trees")
}
