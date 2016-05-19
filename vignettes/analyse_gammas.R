## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- collect_gamma_statistics(phylogenies)
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_species_tree_gammas(filename)
testit::assert(names(df) == c("species_tree", "gamma_stat"))
testit::assert(nrow(df) == 2)
knitr::kable(df)

## ------------------------------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_posterior_gammas(filename)
testit::assert(names(df) == 
  c("species_tree", "alignment", "beast_run", "gamma_stat")
)
testit::assert(nrow(df) == 80)
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
csv_filename_posterior     <- "collected_gammas_posterior.csv"
zip_filename_posterior     <- "collected_gammas_posterior.csv.zip"
csv_filename_parameters    <- "collected_parameters.csv"
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

df_parameters <- read.csv(
  file = csv_filename_parameters, 
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
counter <- 0
interesting_values <- NULL
for (stat in df_species_trees$gamma_stat){
  counter <- counter + 1
  if ( !is.na(stat) && (stat < -10)){
    interesting_values$filenames  <- c(interesting_values$filenames,
                                       df_species_trees$filenames[counter])
    interesting_values$gamma_stat <- c(interesting_values$gamma_stat, stat)
  }
}
interesting_values <- data.frame(interesting_values)

## ------------------------------------------------------------------------
knitr::kable(interesting_values)

## ------------------------------------------------------------------------
# counter <- 0
# counter3 <- 0
# stuff   <- NULL
# for (posterior in df_posterior$filenames){
#   counter  <- counter + 1
#   counter3 <- counter3 + 1
#   counter2 <- 0
#   for (filename in interesting_values$filenames){
#     counter2 <- counter2 + 1
#     if (posterior == filename){
#       stuff$filenames  <- c(stuff$filenames,
#                             df_posterior$filenames[counter])
#       stuff$gamma_post <- c(stuff$gamma_post, df_posterior$gamma_stat[counter])
#       stuff$gamma_int  <- c(stuff$gamma_int, 
#                             interesting_values$gamma_stat[counter2])
#     }
#   }
# }
# 
# stuff <- data.frame(stuff)
# knitr::kable(head(stuff))


