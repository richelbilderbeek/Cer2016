#' Collects the number of taxa of all phylogenies belonging to a
#' multiple parameter file in the melted/uncast/long form
#' @param filenames names of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe with all number of taxa of all files
#' @export
collect_files_n_taxa <- function(
  filenames,
  verbose = FALSE
) {
  if (length(filenames) < 1) {
    stop(
      "collect_files_n_taxa: ",
      "there must be at least one filename supplied"
    )
  }
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_files_n_taxa: ",
      "verbose should be TRUE or FALSE"
    )
  }

  # Species trees
  n_taxa <- NULL
  for (filename in filenames) {
    this_n_taxa <- NULL
    tryCatch(
      this_n_taxa <- collect_species_tree_n_taxa(
        filename = filename,
        verbose = verbose
      ),
      error = function(msg) {
        if (verbose) print(msg)
      }
    )
    if (is.null(this_n_taxa)) {
      this_n_taxa <- data.frame(
        n_taxa = NA
      )
    }
    if (!is.null(n_taxa)) {
      n_taxa <- rbind(n_taxa, this_n_taxa)
    } else {
      n_taxa <- this_n_taxa
    }
  }
  df <- data.frame(
    filenames = basename(filenames),
    n_taxa = n_taxa$n_taxa
  )
  testit::assert(nrow(df) == length(filenames))
  testit::assert(names(df) == c("filenames", "n_taxa"))
  return(df)
}
