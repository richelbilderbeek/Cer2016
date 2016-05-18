## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
dt <- 0.1

## ------------------------------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- ribir::get_nltt_values(phylogenies, dt = dt)
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_species_tree_nltts(filename, dt = dt)
testit::assert(names(df) == c("species_tree", "t", "nltt"))
testit::assert(nrow(df) == 2 * (1 + (1 / dt)))
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_posterior_nltts(filename, dt = dt)
testit::assert(names(df) == 
  c("species_tree", "alignment", "beast_run", "state", "t", "nltt")
)
testit::assert(nrow(df) == 880)
knitr::kable(head(df))

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_file_gammas(filename)
testit::assert(names(df) == c("species_tree_gammas", "posterior_gammas"))
testit::assert(
  names(df$species_tree_gammas) == c("species_tree", "gamma_stat")
)
testit::assert(names(df$posterior_gammas) == 
  c("species_tree", "alignment", "beast_run", "gamma_stat")
)
testit::assert(nrow(df$species_tree_gammas) == 2)
testit::assert(nrow(df$posterior_gammas) == 80)

## ------------------------------------------------------------------------
folder <- "/home/p230198/Peregrine"
all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
df <- collect_files_gammas(head(all_parameter_filenames), verbose = TRUE)
testit::assert(names(df) 
  == c("species_tree_gamma_stats", "posterior_gamma_stats")
)
knitr::kable(df$species_tree_gamma_stats)
knitr::kable(head(df$posterior_gamma_stats))

## ------------------------------------------------------------------------
csv_filename_species_trees <- "collected_gammas_species_trees.csv"
csv_filename_posterior <- "collected_gammas_posterior.csv"
zip_filename_posterior <- "collected_gammas_posterior.csv.zip"
create_fresh <- FALSE # Set this to TRUE and for a >60 mins calculation
if (create_fresh) {
  folder <- "/home/p230198/Peregrine"
  all_parameter_filenames <- paste(
    folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
  )
  df <- collect_files_gammas(all_parameter_filenames, verbose = TRUE)
  write.csv(
    x = df$species_tree_gamma_stats,
    file = csv_filename_species_trees,
    row.names = TRUE
  )
  write.csv(
    x = df$posterior_gamma_stats,
    file = csv_filename_posterior,
    row.names = TRUE
  )
}
if (!file.exists(csv_filename_posterior)) {
  utils::unzip(zip_filename_posterior)
}
testit::assert(file.exists(csv_filename_species_trees))
testit::assert(file.exists(csv_filename_posterior))

## ------------------------------------------------------------------------
df_species_trees <- read.csv(
 file = csv_filename_species_trees, 
 header = TRUE, 
 stringsAsFactors = FALSE, 
 row.names = 1
)

df_posterior <- read.csv(
 file = csv_filename_posterior, 
 header = TRUE, 
 stringsAsFactors = FALSE, 
 row.names = 1
)

## ------------------------------------------------------------------------
knitr::kable(head(df_species_trees))

## ------------------------------------------------------------------------
knitr::kable(head(df_posterior))

## ------------------------------------------------------------------------
str(df_species_trees)
names(df_species_trees)

## ------------------------------------------------------------------------
str(df_posterior)
names(df_posterior)

## ------------------------------------------------------------------------
ggplot2::ggplot(
  data = df_species_trees, ggplot2::aes(df_species_trees$gamma_stat)
) + ggplot2::geom_histogram(binwidth = 1)

## ------------------------------------------------------------------------
ggplot2::ggplot(
  data = df_posterior, ggplot2::aes(df_posterior$gamma_stat)
) + ggplot2::geom_histogram(binwidth = 1)

## ------------------------------------------------------------------------
species_trees_with_low_gamma <- df_species_trees[ 
  !is.na(df_species_trees$gamma_stat) & df_species_trees$gamma_stat < -5, 
]
knitr::kable(head(species_trees_with_low_gamma))

## ------------------------------------------------------------------------
csv_filename_parameters <- "collected_parameters.csv"
testit::assert(file.exists(csv_filename_parameters))
df_parameters <- read.csv(
 file = csv_filename_parameters, 
 header = TRUE, 
 stringsAsFactors = FALSE, 
 row.names = 1
)
knitr::kable(head(df_parameters))

## ------------------------------------------------------------------------
parameters_with_low_gamma <- df_parameters[ 
  rownames(df_parameters) %in% species_trees_with_low_gamma$filename,
]
knitr::kable(head(parameters_with_low_gamma))

