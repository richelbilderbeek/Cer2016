#' Collects the gamm statistics of all phylogenies belonging to a
#' parameter file in the melted/uncast/long form
#'
#' @param filename name of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe of gamma statistics of each phylogeny in time
#' @export
collect_file_gammas <- function(
  filename,
  verbose = FALSE
) {
  if (length(filename) < 1) {
    stop(
      "collect_gamma_statistics_from_file: ",
      "there must be exactly one filename supplied"
    )
  }
  if (!is_valid_file(filename = filename, verbose = verbose)) {
    stop(
      "collect_gamma_statistics_from_file: ",
      "invalid file '", filename, "'"
    )
  }
  species_tree_gammas <- collect_species_tree_gammas(filename)
  posterior_gammas <- collect_posterior_gammas(filename)

  return(
    list(
      species_tree_gammas = species_tree_gammas,
      posterior_gammas = posterior_gammas
    )
  )
}
