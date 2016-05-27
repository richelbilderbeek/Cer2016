csv_filename_species_trees <- "vignettes/collected_gammas_species_trees.csv"
csv_filename_posterior     <- "vignettes/collected_gammas_posterior.csv"
csv_filename_parameters    <- "vignettes/collected_parameters.csv"
csv_filename_comparison    <- "vignettes/femke.csv"

df_big

df_big$mutation_rate <- as.factor(df_big$mutation_rate)

ggplot(df_big, aes(x = diff, colour = mutation_rate)) +
  geom_density() +
  xlim(c(-1, 0.2)) +
  ggtitle("Comparison Mutation rate") +
  xlab("Diff sampled tree - posterior")
