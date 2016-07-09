#' Reads the file with the collected parameters
#' @return a data frame with all parameters
#' @author Richel Bilderbeek
#' @export
read_collected_parameters <- function() {
  csv_filename <- Cer2016::find_path("collected_parameters.csv")
  testit::assert(file.exists(csv_filename))
  df <- read.csv(
    file = csv_filename,
    header = TRUE,
    stringsAsFactors = FALSE,
    row.names = 1
  )
  df
}
