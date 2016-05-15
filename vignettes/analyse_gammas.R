## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- collect_gamma_statistics(phylogenies)
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_species_tree_gammas(filename)
testit::assert(names(df) == c("species_tree", "gamma_stat"))
testit::assert(nrow(df) == 2)
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_posterior_gammas(filename)
testit::assert(names(df) == 
  c("species_tree", "alignment", "beast_run", "gamma")
)
testit::assert(nrow(df) == 80)
knitr::kable(head(df))

## ------------------------------------------------------------------------
if (1==2) {
filename <- find_path("toy_example_3.RDa")
df <- collect_file_gammas(filename)
testit::assert(names(df) == c("species_tree_gammas", "posterior_gammas"))
testit::assert(
  names(df$species_tree_gammas) == c("species_tree", "gamma_stat")
)
testit::assert(nrow(df$species_tree_gammas) == 2)
testit::assert(nrow(df$posterior_gammas) == 80)
}

## ------------------------------------------------------------------------
csv_filename_species_trees <- "collected_gammas_species_trees.csv"
csv_filename_posterior <- "collected_gammas_posterior.csv"
#if (!file.exists(csv_filename_species_trees) || !file.exists(csv_filename_posterior)) {
  folder <- "/home/p230198/Peregrine"
  all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
  df <- collect_files_gammas(head(all_parameter_filenames), verbose = TRUE)
  write.csv(
    x = df$species_tree_gammas,
    file = csv_filename_species_trees,
    row.names = TRUE
  )
  write.csv(
    x = df$posterior_gammas,
    file = csv_filename_posterior,
    row.names = TRUE
  )
#}
testit::assert(file.exists(csv_filename_species_trees))
testit::assert(file.exists(csv_filename_posterior))

## ------------------------------------------------------------------------
if (1==2) {
df_species_trees <- read.csv(
 file = csv_filename_species_trees, 
 header = TRUE, 
 stringsAsFactors = FALSE, 
 row.names = 1
)

df_posterior <- read.csv(
 file = csv_filename_posterior, 
 header = TRUE, 
 stringsAsFactors = FALSE, 
 row.names = 1
)
}

## ------------------------------------------------------------------------
#knitr::kable(head(df_species_trees))

## ------------------------------------------------------------------------
#knitr::kable(head(df_posterior))

## ------------------------------------------------------------------------
#str(df_species_trees)
#names(df_species_trees)

## ------------------------------------------------------------------------
#str(df_posterior)
#names(df_posterior)

