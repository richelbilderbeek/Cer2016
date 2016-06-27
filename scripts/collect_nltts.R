library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"

csv_filename_species_trees <- "collected_nltts_species_trees.csv"
csv_filename_posterior <- "collected_nltts_posterior.csv"
dt <- 0.1

fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)

df <- collect_files_nltts(fns, dt = dt, verbose = FALSE)
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

# Analyse and create pdf
file.copy(
  csv_filename_species_trees,
  paste0("../inst/extdata/", csv_filename_species_trees)
)
file.copy(
  csv_filename_posterior,
  paste0("../inst/extdata/", csv_filename_posterior)
)

library(knitr)
library(rmarkdown)

tryCatch(
  knitr::knit("../vignettes/analyse_nltts.Rmd", "analyse_nltts_knitr.pdf"),
  error = function(msg) { message(msg) }
)

tryCatch(
  render("../vignettes/analyse_nltts.Rmd", "analyse_nltts.pdf"),
  error = function(msg) { message(msg) }
)


