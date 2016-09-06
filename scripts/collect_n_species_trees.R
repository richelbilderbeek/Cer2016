library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- Cer2016::collect_files_n_species_trees(fns, verbose = TRUE)

write.csv(
  x = df,
  file = "../inst/extdata/collected_n_species_trees.csv",
  row.names = TRUE
)

warnings()
