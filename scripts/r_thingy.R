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

ggplot2::qplot(diff, data = df_comparison, binwidth = 0.05, xlim = c(-2, 1))

BD <- df_parameters[
  !is.na(df_parameters$speciation_completion_rate)
  & df_parameters$speciation_completion_rate > 2,
  ]
head(BD)

BD_gammas <- df_comparison[
  df_comparison$filenames %in% rownames(BD),
  ]
head(BD_gammas)

ggplot2::qplot(diff, data = BD_gammas, binwidth = 0.005)

