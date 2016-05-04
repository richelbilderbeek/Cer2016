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
  base_filename <- basename(filename)
  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )

  nltt_values <- NA

  for (i in seq(1, n_species_trees_samples)) {
    these_nltt_values <- ribir::get_nltt_values(
      list(file$species_trees_with_outgroup[[i]][[1]]),
      dt = dt
    )
    if (is.na(nltt_values)) {
      nltt_values <- these_nltt_values
    } else {
      nltt_values <- rbind(nltt_values, these_nltt_values)
    }
  }

  ggplot2::ggplot(
    data = nltt_values,
    ggplot2::aes(t, nltt),
    main = "nLTT plots"
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
