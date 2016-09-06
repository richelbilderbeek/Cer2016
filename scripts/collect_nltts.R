library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"

csv_filename_species_trees <- "../inst/extdata/collected_nltts_species_trees.csv"
csv_filename_posterior <- "../inst/extdata/collected_nltts_posterior.csv"
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

library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_nltts.Rmd", output_file =  "~/analyse_nltts.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_nltts.html -o analyse_nltts.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
