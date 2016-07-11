#' Collects the number of sampled species trees of all phylogenies belonging to a
#' multiple parameter file in the melted/uncast/long form
#' @param filenames names of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe with all number of sampled species trees of all files
#' @examples
#'   filenames <- c(
#'    find_path("toy_example_1.RDa"),
#'    find_path("toy_example_2.RDa")
#'  )
#'  df <- collect_files_n_species_trees(filenames, verbose = FALSE)
#'  testit::assert(names(df) == c("filename", "n_species_trees"))
#'  testit::assert(nrow(df) == length(filenames))
#' @export
collect_files_n_species_trees <- function(
  filenames,
  verbose = FALSE
) {
  if (length(filenames) < 1) {
    stop(
      "collect_files_n_species_trees: ",
      "there must be at least one filename supplied"
    )
  }
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_files_n_species_trees: ",
      "verbose should be TRUE or FALSE"
    )
  }

  # Species trees
  n_species_trees <- NULL
  for (filename in filenames) {
    this_n_species_trees <- NULL
    tryCatch(
      this_n_species_trees <- collect_n_species_trees(
        filename = filename,
        verbose = verbose
      ),
      error = function(msg) {
        if (verbose) message(msg)
      }
    )
    if (is.null(this_n_species_trees)) {
      this_n_species_trees <- data.frame(
        n_species_trees = NA
      )
    }
    if (!is.null(n_species_trees)) {
      n_species_trees <- rbind(n_species_trees, this_n_species_trees)
    } else {
      n_species_trees <- this_n_species_trees
    }
  }
  df <- data.frame(
    filename = basename(filenames),
    n_species_trees = n_species_trees$n_species_trees
  )
  testit::assert(nrow(df) == length(filenames))
  testit::assert(names(df) == c("filename", "n_species_trees"))
  return(df)
}
