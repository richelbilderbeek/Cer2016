csv_filename_species_trees <- "vignettes/collected_gammas_species_trees.csv"
csv_filename_posterior     <- "vignettes/collected_gammas_posterior.csv"
csv_filename_parameters    <- "vignettes/collected_parameters.csv"

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

comparison  <- NULL
counter2    <- 0
for (stat in df_posterior$gamma_stat){
  counter  <- 0
  counter2 <- counter2 + 1
  if (!is.na(stat)){
    for (value in df_species_trees$gamma_stat){
      counter <- counter + 1
      if ((df_posterior$filenames[counter2] ==
           df_species_trees$filenames[counter]) && !is.na(value)){
        comparison$filenames  <- c(comparison$filenames,
                                   df_species_trees$filenames[counter])
        comparison$treenumber <- c(comparison$treenumber,
                                   df_species_trees$species_tree[counter])
        comparison$gamma_pbd  <- c(comparison$gamma_pbd, value)
        comparison$gamma_post <- c(comparison$gamma_post, stat)
        comparison$diff       <- c(comparison$diff,
                                   (value - stat))
      }
    }
  }
}
comparison <- data.frame(comparison)

knitr::kable(head(comparison))

#let's plot this

ggplot2::ggplot(
  data = comparison, ggplot2::aes(comparison$gamma_stat)
) + ggplot2::geom_histogram(binwidth = 1)


