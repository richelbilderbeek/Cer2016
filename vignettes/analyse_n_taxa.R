## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- collect_n_taxa(phylogenies)
testit::assert(names(df) == c("n_taxa"))
testit::assert(df == data.frame(n_taxa = c(10, 20)))
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_species_tree_n_taxa(filename)
testit::assert(names(df) == c("n_taxa"))
testit::assert(nrow(df) == 1)
knitr::kable(df)

## ------------------------------------------------------------------------
file <- read_file(filename)
plot(file$species_trees_with_outgroup[[1]][[1]])

## ------------------------------------------------------------------------
trees_filename <- find_path("toy_example_3_1_1_1.trees")
testit::assert(file.exists(trees_filename))
all_trees <- rBEAST::beast2out.read.trees(trees_filename)
plot(all_trees[[1]])

## ------------------------------------------------------------------------
folder <- "/home/p230198/Peregrine"
all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
df <- collect_files_n_taxa(head(all_parameter_filenames, n= 10), verbose = FALSE)
testit::assert(names(df) == c("filenames", "n_taxa"))
names(df)
knitr::kable(df)

## ------------------------------------------------------------------------
csv_filename_n_taxa <- "collected_n_taxa.csv"
csv_filename_parameters <- "collected_parameters.csv"
create_fresh <- FALSE # Set this to TRUE for a >2 mins calculation
if (create_fresh) {
  folder <- "/home/p230198/Peregrine"
  all_parameter_filenames <- paste(
    folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
  )
  df <- collect_files_n_taxa(all_parameter_filenames, verbose = FALSE)
  write.csv(
    x = df,
    file = csv_filename_n_taxa,
    row.names = TRUE
  )
}
testit::assert(file.exists(csv_filename_n_taxa))

## ------------------------------------------------------------------------
df_n_taxa <- read.csv(
 file = csv_filename_n_taxa, 
 header = TRUE, 
 stringsAsFactors = FALSE, 
 row.names = 1
)

df_parameters <- read.csv(
  file = csv_filename_parameters, 
  header = TRUE, 
  stringsAsFactors = FALSE, 
  row.names = 1
)

## ------------------------------------------------------------------------
knitr::kable(head(df_n_taxa))

## ------------------------------------------------------------------------
str(df_n_taxa)
names(df_n_taxa)

## ------------------------------------------------------------------------
useful_n_taxa <- df_n_taxa[ !is.na(df_n_taxa$n_taxa), ]
ggplot2::ggplot(
  data = useful_n_taxa, ggplot2::aes(useful_n_taxa$n_taxa)
) + ggplot2::geom_histogram(bins = 30)

## ------------------------------------------------------------------------
ggplot2::ggplot(
  data = useful_n_taxa, ggplot2::aes(useful_n_taxa$n_taxa)
) + ggplot2::geom_density()

