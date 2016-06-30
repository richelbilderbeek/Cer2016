#' Collect the gamma statistics of the species trees with outgroup
#' @param filename name of the file containing the parameters and results
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return a data frame
#' @examples
#'  filename <- find_path("toy_example_1.RDa")
#'  df <- collect_species_tree_gammas(filename)
#'  testit::assert(names(df) == c("species_tree", "gamma_stat"))
#'  testit::assert(nrow(df) == 1)
#'  testit::assert(abs(df$gamma_stat - -0.7585369) < 0.0001)
#' @export
#' @author Richel Bilderbeek
collect_species_tree_gammas <- function(
  filename,
  verbose = FALSE
) {

  if (verbose != TRUE && verbose != FALSE) {
    stop("collect_species_tree_gammas: verbose should be TRUE or FALSE")
  }
  if (!is_valid_file(filename)) {
    stop("collect_species_tree_gammas: invalid file")
  }
  file <- Cer2016::read_file(filename)

  df <- NULL

  for (sti in 1:2) {
    phylogeny <- NA
    g <- NA
    tryCatch(
      phylogeny <- Cer2016::get_species_tree_by_index(file = file, sti = sti),
      error = function(msg) {} # nolint
    )
    if (is_phylogeny(phylogeny)) {
      g <- ape::gammaStat(phylogeny)
    }

    # Remove id column
    this_df <- data.frame(
      species_tree = sti,
      gamma_stat = g
    )
    if (is.null(df)) {
      df <- this_df
    } else {
      df <- rbind(df, this_df)
    }
  }
  df
}
