#' Collects the gamma statistics of all phylogenies belonging to a
#' multiple parameter file in the melted/uncast/long form
#' @param filenames names of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A list with two dataframes of gamma statistics
#' @export
collect_files_gammas <- function(
  filenames,
  verbose = FALSE
) {
  if (length(filenames) < 1) {
    stop(
      "collect_gamma_statistics_from_file: ",
      "there must be at least one filename supplied"
    )
  }

  gs <- list(
      species_tree_gammas = NULL,
      posterior_gammas = NULL
    )

#   if (!is_valid_file(filename = filename, verbose = verbose)) {
#     stop(
#       "collect_gamma_statistics_from_file: ",
#       "invalid file '", filename, "'"
#     )
#   }
#   species_tree_gammas <- collect_species_tree_gammas(filename)
#   posterior_gammas <- collect_posterior_gammas(filename)

  return(gs)
}
