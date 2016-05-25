csv_filename_species_trees <- "vignettes/collected_gammas_species_trees.csv"
csv_filename_posterior     <- "vignettes/collected_gammas_posterior.csv"
csv_filename_parameters    <- "vignettes/collected_parameters.csv"
csv_filename_comparison    <- "vignettes/femke.csv"

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

df_comparison <- read.csv(
  file = csv_filename_comparison,
  header = TRUE,
  stringsAsFactors = FALSE,
  row.names = 1
)

ggplot2::qplot(diff, data = df_comparison, binwidth = 0.05, xlim = c(-2, 2))

gamma_bigdiff <- df_comparison[
  !is.na(df_comparison$diff) & df_comparison$diff < -1,
  ]
gamma_bigdiff

parameters_bigdiff <- df_parameters[
  rownames(df_parameters) %in% gamma_bigdiff$filenames,
  ]
parameters_bigdiff

ggplot2::qplot(species_initiation_rate_good_species, data = parameters_bigdiff,
               binwidth = 0.1, xlim = c(0, 2))

