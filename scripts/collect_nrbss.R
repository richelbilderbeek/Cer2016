library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"

csv_filename_nrbss <- "collected_nrbss.csv"

fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- collect_files_nrbss(fns, verbose = FALSE)
write.csv(
  x = df
  file = csv_filename_species_trees,
  row.names = TRUE
)

# Analyse and create pdf
file.copy(
  csv_filename_posterior,
  paste0("../inst/extdata/", csv_filename_nrbss)
)

library(knitr)
library(rmarkdown)

tryCatch(
  knit2pdf("../vignettes/analyse_nrbss.Rmd", "analyse_nrbss.md"),
  error = function(msg) { message(msg) }
)

tryCatch(
  render("../vignettes/analyse_nrbss.Rmd", "analyse_nrbss.pdf"),
  error = function(msg) { message(msg) }
)
