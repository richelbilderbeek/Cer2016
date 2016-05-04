#' Collect the nLTT values of the species trees with outgroup
#' @param filename name of the file containing the parameters and results
#' @param dt the resolution of the nLTT plot,
#'   must be in range <0,1>, default is 0.001
#' @return a data frame
#' @export
#' @author Richel Bilderbeek
collect_species_tree_with_outgroup_nltt_values <- function(
  filename,
  dt = 0.001
) {
  if (!is_valid_file(filename)) {
    stop("collect_species_tree_with_outgroup_nltt_values: invalid filename")
  }
  file <- read_file(filename)

  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )

  df <- NA

  for (i in seq(1, n_species_trees_samples)) {
    nltt_values <- ribir::get_nltt_values(
      list(file$species_trees_with_outgroup[[i]][[1]]),
      dt = dt
    )

    # Remove id column
    nltt_values <- subset(nltt_values, select = -c(id) )

    n_nltt_values <- nrow(nltt_values)
    this_df <- data.frame(
      species_tree = rep(i, n_nltt_values)
    )
    this_df <- cbind(this_df, nltt_values)
    if (is.na(df)) {
      df <- this_df
    } else {
      df <- rbind(df, this_df)
    }
  }
  df
}