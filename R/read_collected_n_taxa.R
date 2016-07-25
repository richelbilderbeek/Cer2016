#' Reads the file with the collected number of taxa
#' @return a data frame with all parameters
#' @author Richel Bilderbeek
#' @export
read_collected_n_taxa <- function() {
  csv_filename <- Cer2016::find_path("collected_n_taxa.csv")
  testit::assert(file.exists(csv_filename))
  df <- utils::read.csv(
    file = csv_filename,
    header = TRUE,
    stringsAsFactors = FALSE,
    row.names = 1
  )
  df
}
