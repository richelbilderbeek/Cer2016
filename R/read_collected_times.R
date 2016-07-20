#' Reads the file with the collected times
#' @return a list containing two data frames,
#'   'per_file' and 'full_process', with the time measurements
#'   per file and for the full process.
#' @author Richel Bilderbeek
#' @export
read_collected_times <- function() {
  csv_filename_per_file <- Cer2016::find_path(
    "collected_times_per_file.csv"
  )
  csv_filename_for_process <- Cer2016::find_path(
    "collected_times_for_process.csv"
  )
  testit::assert(file.exists(csv_filename_per_file))
  testit::assert(file.exists(csv_filename_for_process))
  df_per_file <- utils::read.csv(
    file = csv_filename_per_file,
    header = TRUE,
    stringsAsFactors = FALSE,
    row.names = 1
  )
  df_for_process <- utils::read.csv(
    file = csv_filename_for_process,
    header = TRUE,
    stringsAsFactors = FALSE,
    row.names = 1
  )
  out <- list(per_file = df_per_file, full_process = df_for_process)
  testit::assert(names(out) == c("per_file", "full_process"))
  out
}
