## ------------------------------------------------------------------------
library(Cer2016)
csv_filename <- "collect_parameters.csv"

## ------------------------------------------------------------------------
df_in <- data.frame(
  filenames = c("a.txt","b.txt","c.txt"),
  x = c(1,2,3), y = c(1,4,9)
)
knitr::kable(head(df_in))
write.csv(x = df_in, file = csv_filename)
df_out <- read.csv(file = csv_filename, 
  header = TRUE, 
  stringsAsFactors = FALSE
)
knitr::kable(head(df_out))


## ------------------------------------------------------------------------
#if (!file.exists(csv_filename)) {
  folder <- "/home/p230198/Peregrine"
  all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
  df <- collect_parameters(head(all_parameter_filenames), verbose = TRUE)

## ------------------------------------------------------------------------
knitr::kable(head(df))

## ------------------------------------------------------------------------
  write.csv(
    x = df,
    file = csv_filename,
  )
#}

## ------------------------------------------------------------------------
df <- read.csv(
  file = csv_filename, 
  header = TRUE, 
  stringsAsFactors = FALSE
)

## ------------------------------------------------------------------------
knitr::kable(head(df))

