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

# Analyse and create pdf
file.copy("collected_n_taxa.csv", "../inst/extdata/collected_n_taxa.csv")

library(knitr)
library(rmarkdown)

tryCatch(
  knitr::knit("../vignettes/analyse_n_taxa.Rmd", "analyse_n_taxa.pdf"),
  error = function(msg) { message(msg) }
)

tryCatch(
  render("../vignettes/analyse_n_taxa.Rmd", "analyse_n_taxa.pdf"),
  error = function(msg) { message(msg) }
)


