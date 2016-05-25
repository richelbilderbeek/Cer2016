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

gamma_smalldiff <- df_comparison[
  !is.na(df_comparison$diff) & df_comparison$diff > -1,
  ]
head(gamma_smalldiff)

parameters_smalldiff <- df_parameters[
  rownames(df_parameters) %in% gamma_smalldiff$filenames,
  ]
head(parameters_smalldiff)

gamma_bigdiff <- df_comparison[
  !is.na(df_comparison$diff) & df_comparison$diff < -1,
  ]
head(gamma_bigdiff)

parameters_bigdiff <- df_parameters[
  rownames(df_parameters) %in% gamma_bigdiff$filenames,
  ]
head(parameters_bigdiff)

ggplot2::qplot(sequence_length, data = parameters_bigdiff,
               binwidth = 0.5, xlim = c(999, 1001))

ggplot2::qplot(sequence_length, data = parameters_smalldiff,
               binwidth = 0.5, xlim = c(999, 1001))

ggplot2::qplot(speciation_completion_rate, data = parameters_bigdiff,
               binwidth = 0.05, xlim = c(999999, 1000001))

