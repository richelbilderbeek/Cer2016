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

  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )

  df <- NULL

  for (i in seq(1, n_species_trees_samples)) {
    phylogeny <- file$species_trees_with_outgroup[[i]][[1]]
    g <- NA
    if (!inherits(phylogeny, "phylo")) {
      if (verbose) {
        message(
          "collect_species_tree_gammas: ",
          "phylogeny must inherit from class 'phylo', ",
          "class is '", class(phylogeny), "'"
        )
      }
    } else {
      g <- ape::gammaStat(phylogeny)
    }

    # Remove id column
    this_df <- data.frame(
      species_tree = i,
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
