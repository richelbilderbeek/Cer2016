#' Collects the gamma statistics of all phylogenies belonging to a
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
  if (length(filename) != 1) {
    stop(
      "collect_file_gammas: ",
      "there must be exactly one filename supplied"
    )
  }
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_file_gammas: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename = filename, verbose = verbose)) {
    stop(
      "collect_file_gammas: ",
      "invalid file '", filename, "'"
    )
  }

  species_tree_gammas <- Cer2016::collect_species_tree_gammas(filename)
  posterior_gammas <- Cer2016::collect_posterior_gammas(filename)

  return(
    list(
      species_tree_gammas = species_tree_gammas,
      posterior_gammas = posterior_gammas
    )
  )
}
