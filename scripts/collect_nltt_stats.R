library(Cer2016)
folder <- "/home/p230198/GitHubs/Cer2016/scripts"
csv_filename_nltt_stat <- "../inst/extdata/collected_nltt_stats.csv"

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

warnings()
