## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
dt <- 0.1

## ------------------------------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- ribir::get_nltt_values(phylogenies, dt = dt)
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_species_tree_nltts(filename, dt = dt)
testit::assert(names(df) == c("species_tree", "t", "nltt"))
testit::assert(nrow(df) == 2 * (1 + (1 / dt)))
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_posterior_nltts(filename, dt = dt)
testit::assert(names(df) == 
  c("species_tree", "alignment", "beast_run", "state", "t", "nltt")
)
testit::assert(nrow(df) == 880)
knitr::kable(head(df))

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_file_nltts(filename, dt = dt)
testit::assert(names(df) == c("species_tree_nltts", "posterior_nltts"))
testit::assert(
  names(df$species_tree_nltts) == c("species_tree", "t", "nltt")
)
testit::assert(names(df$posterior_nltts) == 
  c("species_tree", "alignment", "beast_run", "state", "t", "nltt")
)
testit::assert(nrow(df$species_tree_nltts) > 0)
testit::assert(nrow(df$posterior_nltts) > 0)
knitr::kable(head(df$species_tree_nltts))
knitr::kable(head(df$posterior_nltts))

## ------------------------------------------------------------------------
if ("Skip this" == TRUE) {
  folder <- "/home/p230198/Peregrine"
  all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
  df <- collect_files_nltts(head(all_parameter_filenames), verbose = TRUE)
  testit::assert(names(df) 
    == c("species_tree_nltts", "posterior_nltts")
  )
  knitr::kable(head(df$species_tree_nltts))
  knitr::kable(head(df$posterior_nltts))
}

## ------------------------------------------------------------------------
if ("Skip this" == TRUE) {
  csv_filename_species_trees <- "collected_nltts_species_trees.csv"
  csv_filename_posterior <- "collected_nltts_posterior.csv"
  zip_filename_posterior <- "collected_nltts_posterior.csv.zip"
  # Set this to TRUE for a >60 mins calculation that failed on my powerfull computer
  create_fresh <- TRUE 
  if (create_fresh) {
    folder <- "/home/p230198/Peregrine"
    all_parameter_filenames <- paste(
      folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
    )
    df <- collect_files_nltts(all_parameter_filenames, verbose = TRUE)
    write.csv(
      x = df$species_tree_nltts,
      file = csv_filename_species_trees,
      row.names = TRUE
    )
    write.csv(
      x = df$posterior_nltts,
      file = csv_filename_posterior,
      row.names = TRUE
    )
  }
}
#if (!file.exists(csv_filename_posterior)) {
#  utils::unzip(zip_filename_posterior)
#}
#testit::assert(file.exists(csv_filename_species_trees))
#testit::assert(file.exists(csv_filename_posterior))

## ------------------------------------------------------------------------
# df_species_trees <- read.csv(
#  file = csv_filename_species_trees, 
#  header = TRUE, 
#  stringsAsFactors = FALSE, 
#  row.names = 1
# )
# 
# df_posterior <- read.csv(
#  file = csv_filename_posterior, 
#  header = TRUE, 
#  stringsAsFactors = FALSE, 
#  row.names = 1
# )

## ------------------------------------------------------------------------
# knitr::kable(head(df_species_trees))

## ------------------------------------------------------------------------
# knitr::kable(head(df_posterior))

## ------------------------------------------------------------------------
# str(df_species_trees)
# names(df_species_trees)

## ------------------------------------------------------------------------
# str(df_posterior)
# names(df_posterior)

## ------------------------------------------------------------------------
# ggplot2::ggplot(
#   data = df_species_trees, ggplot2::aes(df_species_trees$nltt)
# ) + ggplot2::geom_histogram(binwidth = 1)

## ------------------------------------------------------------------------
# ggplot2::ggplot(
#   data = df_posterior, ggplot2::aes(df_posterior$nltt)
# ) + ggplot2::geom_histogram(binwidth = 1)

