#' Read all the collected nLTT values of all species trees
#' @return a dataframe
#' @examples
#'   df <- read_collected_nltts_strees()
#'   testit::assert(names(df) == c("filenames", "species_tree", "t", "nltt"))
#' @author Richel Bilderbeek
#' @export
read_collected_nltts_strees <- function() {
  filename <- find_path("collected_nltts_species_trees.csv")
  testit::assert(file.exists(filename))
  df <- read.csv(
   file = filename,
   header = TRUE,
   stringsAsFactors = FALSE,
   row.names = 1
  )
  df$species_tree <- as.factor(df$species_tree)
  df
}
