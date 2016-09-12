#' Collects the ESSes of all phylogenies belonging to the
#' parameter files in the melted/uncast/long form
#'
#' @param filenames names of the parameter files
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return A dataframe of ESSes for all files their posterior
#' @examples
#'   filenames <- find_paths(c("toy_example_3.RDa", "toy_example_4.RDa"))
#'   df <- collect_files_esses(filenames)
#'   testit::assert(nrow(df) == 16)
#' @export
collect_files_esses <- function(
  filenames,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop("verbose should be TRUE or FALSE")
  }
  if (length(filenames) == 0) {
    stop(
      "there must be exactly at least one filename supplied"
    )
  }
  for (filename in filenames) {
    if (!is_valid_file(filename = filename, verbose = verbose)) {
      stop(
        "invalid file '", filename, "'"
      )
    }
  }
  n_filenames_before <- length(filenames)
  df <- Cer2016::collect_file_esses(filenames[1])
  filenames <- utils::tail(filenames, length(filenames) - 1)
  n_filenames_after <- length(filenames)
  testit::assert(n_filenames_after == n_filenames_before - 1)

  for (filename in filenames) {
    df <- rbind(df, Cer2016::collect_file_esses(filename))
  }

  testit::assert(names(df)
    == c("filename", "sti", "ai", "pi", "min_ess")
  )
  df
}
