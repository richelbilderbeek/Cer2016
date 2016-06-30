#' Collects the number of alignments of all phylogenies belonging to a
#' multiple parameter file in the melted/uncast/long form
#' @param filenames names of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe with all number of sampled alignments of all files
#' @examples
#'   filenames <- c(
#'     find_path("toy_example_1.RDa"),
#'     find_path("toy_example_3.RDa")
#'   )
#'   df <- collect_files_n_alignments(filenames)
#'   testit::assert(names(df) == c("filenames", "n_alignments"))
#'   testit::assert(nrow(df) == length(filenames))
#'   testit::assert(df$n_alignments == c(2, 4))
#' @export
collect_files_n_alignments <- function(
  filenames,
  verbose = FALSE
) {
  if (length(filenames) < 1) {
    stop(
      "collect_files_n_alignments: ",
      "there must be at least one filename supplied"
    )
  }
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_files_n_alignments: ",
      "verbose should be TRUE or FALSE"
    )
  }

  # alignments
  n_alignments <- NULL
  for (filename in filenames) {
    this_n_alignments <- NULL
    tryCatch(
      this_n_alignments <- collect_n_alignments(
        filename = filename,
        verbose = verbose
      ),
      error = function(msg) {
        if (verbose) message(msg)
      }
    )
    if (is.null(this_n_alignments)) {
      this_n_alignments <- data.frame(
        n_alignments = NA
      )
    }
    if (!is.null(n_alignments)) {
      n_alignments <- rbind(n_alignments, this_n_alignments)
    } else {
      n_alignments <- this_n_alignments
    }
  }
  df <- data.frame(
    filenames = basename(filenames),
    n_alignments = n_alignments$n_alignments
  )
  testit::assert(nrow(df) == length(filenames))
  testit::assert(names(df) == c("filenames", "n_alignments"))
  return(df)
}
