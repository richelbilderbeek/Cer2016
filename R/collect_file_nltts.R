#' Collects the nLTTs of all phylogenies belonging to a
#' parameter file in the melted/uncast/long form
#'
#' @param filename name of the parameter file
#' @param dt the resolution of the nLTT plot,
#'   must be in range <0,1>, default is 0.001
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe of gamma statistics of each phylogeny in time
#' @examples
#'   dt <- 0.1
#'   filename <- find_path("toy_example_3.RDa")
#'   df <- collect_file_nltts(filename, dt = dt)
#'   testit::assert(names(df) == c("species_tree_nltts", "posterior_nltts"))
#'   testit::assert(names(df$species_tree_nltts)
#'     == c("species_tree", "t", "nltt")
#'   )
#'   testit::assert(nrow(df$species_tree_nltts) > 2)
#'   testit::assert(nrow(df$posterior_nltts) > 80)
#' @export
collect_file_nltts <- function(
  filename,
  dt = 0.001,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop("verbose should be TRUE or FALSE")
  }
  if (length(filename) != 1) {
    stop(
      "there must be exactly one filename supplied"
    )
  }
  if (!is_valid_file(filename = filename, verbose = verbose)) {
    stop(
      "invalid file '", filename, "'"
    )
  }

  species_tree_nltts <- Cer2016::collect_species_tree_nltts(
    filename = filename, dt = dt
  )
  posterior_nltts <- Cer2016::collect_posterior_nltts(
    filename = filename, dt = dt
  )

  return(
    list(
      species_tree_nltts = species_tree_nltts,
      posterior_nltts = posterior_nltts
    )
  )
}
