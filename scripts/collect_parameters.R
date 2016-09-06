library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- Cer2016::collect_parameters(fns, verbose = TRUE)
write.csv(
  x = df,
  file = "../inst/extdata/collected_parameters.csv",
  row.names = TRUE
)

tryCatch(
  rmarkdown::render("../vignettes/analyse_files.Rmd", output_file = "~/analyse_files.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_files.html -o analyse_files.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
