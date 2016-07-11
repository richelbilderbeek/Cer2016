#' Collects the nLTT statistics of all phylogenies belonging to a
#' multiple parameter file in the melted/uncast/long form
#' @param filenames names of the parameter file
#' @param dt the resolution of the nLTT plot,
#'   must be in range <0,1>, default is 0.001
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A list with two dataframes of nLTTs
#' @export
collect_files_nltts <- function(
  filenames,
  dt,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_files_nltts: ",
      "verbose should be TRUE or FALSE"
    )
  }
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
      this_stns <- collect_species_tree_nltts(filename = filename, dt = dt),
      error = function(msg) {
        if (verbose) message(msg)
      }
    )
    if (is.null(this_stns)) {
      this_stns <- data.frame(species_tree = NA, t = NA, nltt = NA)
    }
    # Prepend a col with the filename
    this_filenames <- rep(basename(filename), times = nrow(this_stns))
    this_stns <- cbind(
      filename = this_filenames,
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
      this_pns <- Cer2016::collect_posterior_nltts(
        filename = filename, dt = dt
      ),
      error = function(msg) {
        if (verbose) message(msg)
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
      filename = this_filenames,
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
