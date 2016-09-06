library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
csv_filename_species_trees <- "../inst/extdata/collected_gammas_species_trees.csv"
csv_filename_posterior     <- "../inst/extdata/collected_gammas_posterior.csv"

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

library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_gammas.Rmd", output_file =  "~/analyse_gammas.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_gammas.html -o analyse_gammas.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
