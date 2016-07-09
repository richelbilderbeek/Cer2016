#' Read all the collected nLTT values of all posteriors
#' @return a dataframe
#' @examples
#'   df <- read_collected_nltts_postrs()
#'   testit::assert(names(df) ==
#'     c(
#'       "filenames", "species_tree", "alignment",
#'       "beast_run", "state", "t", "nltt"
#'     )
#'   )
#' @author Richel Bilderbeek
#' @export
read_collected_nltts_postrs <- function() {

  filename <- Cer2016::find_path("collected_nltts_posterior.csv")
  testit::assert(file.exists(filename))
  df <- read.csv(
   file = filename,
   header = TRUE,
   stringsAsFactors = FALSE,
   row.names = 1
  )
  df$species_tree <- as.factor(df$species_tree)
  df$alignment <- as.factor(df$alignment)
  df$beast_run <- as.factor(df$beast_run)
  df
}
