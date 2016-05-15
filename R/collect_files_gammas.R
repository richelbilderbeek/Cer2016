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

  # Species trees
  stgs <- NULL # Species Trees Gamma statistics
  for (filename in filenames) {
    this_stgs <- NULL
    tryCatch(
      this_stgs <- collect_species_tree_gammas(filename),
      error = function(msg) {
        if (verbose) print(msg)
      }
    )
    if (is.null(this_stgs)) {
      this_stgs <- data.frame(species_tree = NA, gamma_stat = NA)
    }
    # Prepend a col with the filename
    this_filenames <- rep(basename(filename), times = nrow(this_stgs))
    this_stgs <- cbind(
      filenames = this_filenames,
      this_stgs
    )
    if (!is.null(stgs)) {
      stgs <- rbind(stgs, this_stgs)
    } else {
      stgs <- this_stgs
    }
  }

  # Posteriors trees
  pgs <- NULL # Posterior Gamma statistics
  for (filename in filenames) {
    this_pgs <- NULL
    tryCatch(
      this_pgs <- collect_posterior_gammas(filename),
      error = function(msg) {
        if (verbose) print(msg)
      }
    )
    if (is.null(this_pgs)) {
      this_pgs <- data.frame(
        species_tree = NA,
        alignment = NA,
        beast_run = NA,
        gamma_stat = NA
      )
    }
    # Prepend a col with the filename
    this_filenames <- rep(basename(filename), times = nrow(this_pgs))
    this_pgs <- cbind(
      filenames = this_filenames,
      this_pgs
    )
    if (!is.null(pgs)) {
      pgs <- rbind(pgs, this_pgs)
    } else {
      pgs <- this_pgs
    }
  }

  gs <- list(
      species_tree_gamma_stats = stgs,
      posterior_gamma_stats = pgs
    )

  return(gs)
}
