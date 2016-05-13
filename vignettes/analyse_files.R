## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------

csv_filename <- "collect_parameters.csv"
if (!file.exists(csv_filename)) {
  folder <- "/home/p230198/Peregrine"
  all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
  df <- collect_parameters(all_parameter_filenames, verbose = TRUE)
  write.csv(
    x = df,
    file = csv_filename,
    row.names = TRUE
  )
}

## ------------------------------------------------------------------------
df <- read.csv(
  file = csv_filename, 
  header = TRUE, 
  stringsAsFactors = FALSE, 
  row.names = 1
)

## ------------------------------------------------------------------------
knitr::kable(head(df))

## ------------------------------------------------------------------------
str(df)
names(df)

## ------------------------------------------------------------------------
ggplot2::ggplot(data = df, ggplot2::aes(df$age)) + ggplot2::geom_histogram(binwidth = 1)

## ------------------------------------------------------------------------
ggplot2::ggplot(data = df, ggplot2::aes(df$sequence_length)) + ggplot2::geom_histogram()

## ------------------------------------------------------------------------
ggplot2::ggplot(data = df, ggplot2::aes(df$sequence_length)) + ggplot2::geom_histogram() + ggplot2::scale_x_log10()

## ------------------------------------------------------------------------
ggplot2::ggplot(data = df, ggplot2::aes(df$sequence_length)) + ggplot2::geom_freqpoly() + ggplot2::scale_x_log10()

## ------------------------------------------------------------------------
csv_filename <- "analyse_files_test.csv"
df_in <- data.frame(
  x = c(1,2,3), y = c(1,4,9)
)
rownames(df_in) <- c("a.txt","b.txt","c.txt")
print(rownames(df_in))
knitr::kable(head(df_in))

## ------------------------------------------------------------------------
write.csv(x = df_in, file = csv_filename, row.names = TRUE)

## ------------------------------------------------------------------------

df_out <- read.csv(file = csv_filename, 
  header = TRUE, 
  stringsAsFactors = FALSE, 
  row.names = 1
)
knitr::kable(head(df_out))

