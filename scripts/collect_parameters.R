library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- Cer2016::collect_parameters(fns, verbose = TRUE)
write.csv(
  x = df,
  file = "collected_parameters.csv",
  row.names = TRUE
)

# Analyse and create pdf
file.copy("collected_parameters.csv", "../inst/extdata/collected_parameters.csv")

library(knitr)
library(rmarkdown)

tryCatch(
  knit2pdf("../vignettes/analyse_files.Rmd", "analyse_files.md"),
  error = function(msg) { print(msg) } 
)

tryCatch(
  render("../vignettes/analyse_files.Rmd", "analyse_files.pdf"),
  error = function(msg) { print(msg) } 
)


