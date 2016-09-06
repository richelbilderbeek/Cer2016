library(Cer2016)
library(methods)
# Collect all filenames and run time from the log files
system("egrep -R \"real[[:blank:]]\" --include=*.log > ../mytmp.txt")
df_filenames <- read.csv("../mytmp.txt", sep = ":", header = FALSE, stringsAsFactor = FALSE)

# df_filenames is a bit messy, with columns named V1 and V2 and messy values
# First, describe the columns
names(df_filenames) <- c("log_filename", "real_time_sec")

# Second, sort by log filename
df_filenames <- df_filenames[order(df_filenames$log_filename),]
rownames(df_filenames) <- NULL

# Third, get all cell values in a usable format
for (i in seq(1, nrow(df_filenames))) {
  # Lose 'real ' in real_time column
  df_filenames[i, 2] <- substr(df_filenames[i, 2], 5, nchar(df_filenames[i, 2]))
  # Lose tabs in real_time column
  df_filenames[i, 2] <- stringr::str_replace(df_filenames[i, 2], "(\\t)", "")
  # Lose spaces in real_time
  df_filenames[i, 2] <- stringr::str_replace(df_filenames[i, 2], "( )", "")
  # Convert the number of seconds from floating point to integer by truncating
  df_filenames[i, 2] <- stringr::str_replace(df_filenames[i, 2], "(\\.[0-9]*s)", "")
  # Convert the m to a colon
  df_filenames[i, 2] <- stringr::str_replace(df_filenames[i, 2], "(m)", ":")
  # Convert time to number of seconds
  df_filenames[i, 2] <- lubridate::period_to_seconds(lubridate::ms(df_filenames[i, 2]))
}

# 'real_time_sec' is a number
df_filenames[ , 2] <- as.numeric(df_filenames[ , 2])

# Create a data frame 'df' that show
# per file the time each process takes
add_alignments_ts <- df_filenames[
  grep(x = df_filenames$log_filename, pattern = "add_alignments"),
]
add_pbd_output_ts <- df_filenames[
  grep(x = df_filenames$log_filename, pattern = "add_pbd_output"),
]
add_posteriors_ts <- df_filenames[
  grep(x = df_filenames$log_filename, pattern = "add_posteriors"),
]
add_species_trees_ts <- df_filenames[
  grep(x = df_filenames$log_filename, pattern = "add_species_trees"),
]

# df: data frame to show the steps per file
df <- read_collected_parameters()
df <- cbind(filename = rownames(df), df)
df <- cbind(df, add_alignments_real_time_sec = add_alignments_ts$real_time_sec)
df <- cbind(df, add_pbd_output_real_time_sec = add_pbd_output_ts$real_time_sec)
df <- cbind(df, add_posteriors_real_time_sec = add_posteriors_ts$real_time_sec)
df <- cbind(df, add_species_trees_real_time_sec = add_species_trees_ts$real_time_sec)


# df_process: data frame to show all steps in the process
df_process <- df_filenames

for (i in seq(1, nrow(df_process))) {
  df_process[i, 1] <- stringr::str_replace(df_process[i, 1], "(_[0-9]*\\.log)", "")
  df_process[i, 1] <- stringr::str_replace(df_process[i, 1], "(\\.log)", "")
}
names(df_process) <- c("process_name", "real_time_sec")
df_process$process_name <- as.factor(df_process$process_name)

# Write data to CSVs
write.csv(
  x = df,
  file = "../inst/extdata/collected_times_per_file.csv",
  row.names = TRUE
)

write.csv(
  x = df_process,
  file = "../inst/extdata/collected_times_for_process.csv",
  row.names = TRUE
)

# Create a PDF
library(rmarkdown)

tryCatch(
  rmarkdown::render("../vignettes/analyse_time.Rmd", output_file =  "~/analyse_time.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/analyse_time.html -o analyse_time.pdf"),
  error = function(msg) { message(msg) }
)


warnings()

