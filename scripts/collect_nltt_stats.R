library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
csv_filename_nltt_stat <- "collected_nltt_stats.csv"

# filenames
fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)

df <- calc_nltt_stats_from_files(fns)
write.csv(
  x = df,
  file = csv_filename_nltt_stat,
  row.names = TRUE
)

# Analyse and create pdf
file.copy(
  csv_filename_nltt_stat,
  paste0("../inst/extdata/", csv_filename_nltt_stat)
)


#library(rmarkdown)

#tryCatch(
#  rmarkdown::render("../vignettes/analyse_nltts.Rmd", output_file =  "~/analyse_nltts.html"),
#  error = function(msg) { message(msg) }
#)

#tryCatch(
#  system("pandoc ~/analyse_nltts.html -o analyse_nltts.pdf"),
#  error = function(msg) { message(msg) }
#)

warnings()
