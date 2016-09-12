library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
csv_filename_esses <- "../inst/extdata/collected_esses.csv"

fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)

df <- collect_files_esses(fns, verbose = FALSE)
write.csv(
  x = df,
  file = csv_filename_esses,
  row.names = TRUE
)

library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_esses.Rmd", output_file =  "~/analyse_esses.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_esses.html -o analyse_esses.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
