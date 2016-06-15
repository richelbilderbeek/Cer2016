library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- Cer2016::collect_files_n_taxa(fns, verbose = TRUE)
write.csv(
  x = df,
  file = "collected_n_taxa.csv",
  row.names = TRUE
)