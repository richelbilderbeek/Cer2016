#' Collects the nLTT statistics of all phylogenies belonging to a
#' multiple parameter file in the melted/uncast/long form
#' @param filenames names of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A list with two dataframes of nLTTs
#' @export
collect_files_nltts <- function(
  filenames,
  verbose = FALSE
) {
  if (length(filenames) < 1) {
    stop(
      "collect_files_nltts: ",
      "there must be at least one filename supplied"
    )
  }

  # Species trees
  stns <- NULL # Species Trees Normalized lineaegs through timeS
  for (filename in filenames) {
    this_stns <- NULL
    tryCatch(
      this_stns <- collect_species_tree_nltts(filename),
      error = function(msg) {
        if (verbose) print(msg)
      }
    )
    if (is.null(this_stns)) {
      this_stns <- data.frame(species_tree = NA, t = NA, nltt = NA)
    }
    # Prepend a col with the filename
    this_filenames <- rep(basename(filename), times = nrow(this_stns))
    this_stns <- cbind(
      filenames = this_filenames,
      this_stns
    )
    if (!is.null(stns)) {
      stns <- rbind(stns, this_stns)
    } else {
      stns <- this_stns
    }
  }

  # Posteriors Normalized lineages through timeS
  pns <- NULL # Posterior Gamma statistics
  for (filename in filenames) {
    this_pns <- NULL
    tryCatch(
      this_pns <- collect_posterior_nltts(filename),
      error = function(msg) {
        if (verbose) print(msg)
      }
    )
    if (is.null(this_pns)) {
      this_pns <- data.frame(
        species_tree = NA,
        alignment = NA,
        beast_run = NA,
        state = NA,
        t = NA,
        nltt = NA
      )
    }
    # Prepend a col with the filename
    this_filenames <- rep(basename(filename), times = nrow(this_pns))
    this_pns <- cbind(
      filenames = this_filenames,
      this_pns
    )
    if (!is.null(pns)) {
      pns <- rbind(pns, this_pns)
    } else {
      pns <- this_pns
    }
  }

  gs <- list(
      species_tree_nltts = stns,
      posterior_nltts = pns
    )

  return(gs)
}
