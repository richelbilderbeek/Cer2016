#' Collects the gamm statistics of all phylogenies belonging to a
#' parameter file in the melted/uncast/long form
#'
#' @param filename name of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe of gamma statistics of each phylogeny in time
#' @examples
#'   filename <- find_path("toy_example_3.RDa")
#'   df <- collect_file_gammas(filename)
#'   testit::assert(names(df) == c("species_tree_gammas", "posterior_gammas"))
#'   testit::assert(names(df$species_tree_gammas)
#'     == c("species_tree", "gamma_stat")
#'   )
#'   testit::assert(nrow(df$species_tree_gammas) == 2)
#'   testit::assert(nrow(df$posterior_gammas) == 80)
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
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "show_parameter_files: ",
      "verbose should be TRUE or FALSE"
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
