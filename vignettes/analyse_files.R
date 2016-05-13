## ------------------------------------------------------------------------
library(Cer2016)
csv_filename <- "collect_parameters.csv"

## ------------------------------------------------------------------------
df_in <- data.frame(
  x = c(1,2,3), y = c(1,4,9)
)
rownames(df_in) <- c("a.txt","b.txt","c.txt")
print(rownames(df_in))
knitr::kable(head(df_in))
print(rownames(df_in))
print(colnames(df_in))

write.csv(x = df_in, file = csv_filename, row.names = TRUE)
df_out <- read.csv(file = csv_filename, 
  header = TRUE, 
  stringsAsFactors = FALSE, 
  row.names = 1
)
knitr::kable(head(df_out))
print(rownames(df_out))
print(colnames(df_out))

## ------------------------------------------------------------------------
folder <- "/home/p230198/Peregrine"
all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
df <- collect_parameters(head(all_parameter_filenames), verbose = TRUE)
print(rownames(df))
print(colnames(df))

## ------------------------------------------------------------------------
knitr::kable(head(df))

## ------------------------------------------------------------------------
write.csv(
  x = df,
  file = csv_filename,
  row.names = TRUE
)

## ------------------------------------------------------------------------
df <- read.csv(
  file = csv_filename, 
  header = TRUE, 
  stringsAsFactors = FALSE, 
  row.names = 1
)

## ------------------------------------------------------------------------
knitr::kable(head(df))

