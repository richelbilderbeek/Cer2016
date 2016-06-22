#' Collects the NRBS values of all phylogenies belonging to a
#' multiple parameter file in the melted/uncast/long form
#' @param filenames names of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframes of NRBS values
#' @examples
#'   filenames <- c(
#'     find_path("toy_example_3.RDa"),
#'     find_path("toy_example_4.RDa")
#'   )
#'   df <- collect_files_nrbss(filenames)
#'   testit::assert(names(df) == c("filename", "species_tree", "beast_run", "state", "nrbs"))
#'   testit::assert(nrow(df) == 80)
#' @export
collect_files_nrbss <- function(
  filenames,
  verbose = FALSE
) {

  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_files_nrbss: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (length(filenames) < 1) {
    stop(
      "collect_files_nrbss: ",
      "there must be at least one filename supplied"
    )
  }

  # Species trees
  df <- NULL
  for (filename in filenames) {
    this_df <- NULL
    tryCatch(
      this_df <- collect_file_nrbss(filename),
      error = function(msg) {
        if (verbose) message(msg)
      }
    )
    if (is.null(this_df)) {
      this_df <- data.frame(
        species_tree = NA, beast_run = NA, state = NA, nrbs = NA
      )
    }
    # Prepend a col with the filename
    this_filenames <- rep(basename(filename), times = nrow(this_df))
    this_df <- cbind(
      filenames = this_filenames,
      this_df
    )
    if (!is.null(df)) {
      df <- rbind(df, this_df)
    } else {
      df <- this_df
    }
  }

  df
}
