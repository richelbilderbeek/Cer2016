#' Collects the number of posteriors of all phylogenies belonging to a
#' multiple parameter file in the melted/uncast/long form
#' @param filenames names of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe with all number of sampled posteriors of all files
#' @examples
#'  filenames <- c(
#'    find_path("toy_example_1.RDa"),
#'    find_path("toy_example_3.RDa")
#'  )
#'  df <- collect_files_n_posteriors(filenames)
#'  testit::assert(names(df) == c("filename", "n_posteriors"))
#'  testit::assert(nrow(df) == length(filenames))
#'  testit::assert(df$n_posteriors == c(2, 8))
#' @export
collect_files_n_posteriors <- function(
  filenames,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "collect_files_n_posteriors: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (length(filenames) < 1) {
    stop(
      "collect_files_n_posteriors: ",
      "there must be at least one filename supplied"
    )
  }

  # posteriors
  n_posteriors <- NULL
  for (filename in filenames) {
    this_n_posteriors <- NULL
    tryCatch(
      this_n_posteriors <- collect_n_posteriors(
        filename = filename,
        verbose = verbose
      ),
      error = function(msg) {
        if (verbose) message(msg)
      }
    )
    if (is.null(this_n_posteriors)) {
      this_n_posteriors <- data.frame(
        n_posteriors = NA
      )
    }
    if (!is.null(n_posteriors)) {
      n_posteriors <- rbind(n_posteriors, this_n_posteriors)
    } else {
      n_posteriors <- this_n_posteriors
    }
  }
  df <- data.frame(
    filename = basename(filenames),
    n_posteriors = n_posteriors$n_posteriors
  )
  testit::assert(nrow(df) == length(filenames))
  testit::assert(names(df) == c("filename", "n_posteriors"))
  return(df)
}
