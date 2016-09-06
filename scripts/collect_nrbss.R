library(Cer2016)

folder <- "/home/p230198/GitHubs/Cer2016/scripts"
csv_filename_nrbss <- "../inst/extdata/collected_nrbss.csv"

fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- collect_files_nrbss(fns, verbose = FALSE)
write.csv(
  x = df,
  file = csv_filename_nrbss,
  row.names = TRUE
)

library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_nrbss.Rmd", output_file =  "~/analyse_nrbss.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_nrbss.html -o analyse_nrbss.pdf"),
  error = function(msg) { message(msg) }
)

warnings()
