library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
csv_filename_species_trees <- "collected_gammas_species_trees.csv"
csv_filename_posterior     <- "collected_gammas_posterior.csv"

fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- collect_files_gammas(fns, verbose = FALSE)
write.csv(
  x = df$species_tree_gamma_stats,
  file = csv_filename_species_trees,
  row.names = TRUE
)
write.csv(
  x = df$posterior_gamma_stats,
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
  knit2pdf("../vignettes/analyse_gammas.Rmd", "analyse_gammas.md"),
  error = function(msg) { message(msg) }
)

tryCatch(
  render("../vignettes/analyse_gammas.Rmd", "analyse_gammas.pdf"),
  error = function(msg) { message(msg) }
)


