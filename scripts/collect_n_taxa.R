library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- Cer2016::collect_files_n_taxa(fns, verbose = TRUE)
write.csv(
  x = df,
  file = "../inst/extdata/collected_n_taxa.csv",
  row.names = TRUE
)

library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_n_taxa.Rmd", output_file =  "~/analyse_n_taxa.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_n_taxa.html -o analyse_n_taxa.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
