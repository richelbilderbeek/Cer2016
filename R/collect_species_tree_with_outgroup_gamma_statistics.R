#' Collect the gamma statistics of the species trees with outgroup
#' @param filename name of the file containing the parameters and results
#' @return a data frame
#' @export
#' @author Richel Bilderbeek
collect_species_tree_with_outgroup_gamma_statistics <- function(
  filename,
  dt = 0.001
) {
  if (!is_valid_file(filename)) {
    stop("collect_species_tree_with_outgroup_gamma_statistics: invalid filename")
  }
  file <- read_file(filename)

  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )

  df <- NA

  for (i in seq(1, n_species_trees_samples)) {
    g <- ape::gammaStat(
      file$species_trees_with_outgroup[[i]][[1]]
    )

    # Remove id column
    this_df <- data.frame(
      gamma_stat = g,
      species_tree = i
    )
    if (is.na(df)) {
      df <- this_df
    } else {
      df <- rbind(df, this_df)
    }
  }
  df
}