analysis_femke <- function(
  df_species_trees,
  df_posterior
  n
) {
  comparison  <- NULL
  counter2    <- 0
  for (stat in head(df_posterior$gamma_stat, n = n)) {
    counter  <- 0
    counter2 <- counter2 + 1
    if (!is.na(stat)){
      for (value in df_species_trees$gamma_stat){
        counter <- counter + 1
        testit::assert(counter >= 1)
        testit::assert(counter <= length(df_species_trees$filenames))
        testit::assert(counter2 >= 1)
        testit::assert(counter2 <= length(df_posterior$filenames))
        testit::assert(df_posterior$filenames[counter2] != df_species_trees$filenames[counter])
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
          break
        }
      }
    }
  }
  comparison <- data.frame(comparison)
  comparison
}

analysis_richel <- function(
  df_species_trees,
  df_posterior
) {
  # Do an inner join
  total <- merge(df_species_trees,df_posterior, by = c("filenames", "species_tree"))
  total$diff <- total$gamma_stat.x - total$gamma_stat.y
  total
}

csv_filename_species_trees <- "vignettes/collected_gammas_species_trees.csv"
csv_filename_posterior     <- "vignettes/collected_gammas_posterior.csv"
csv_filename_parameters    <- "vignettes/collected_parameters.csv"
testit::assert(file.exists(csv_filename_species_trees))
testit::assert(file.exists(csv_filename_posterior))
testit::assert(file.exists(csv_filename_parameters))


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

names(df_species_trees)
head(total)

profile_filename <- "rprof.out"

Rprof(filename = profile_filename)
df <- analysis_femke(
  df_species_trees = df_species_trees,
  df_posterior = df_posterior,
  df_parameters = df_parameters,
  n = 2
)
print(nrow(df))
Rprof(NULL)
summaryRprof(file = profile_filename)


knitr::kable(comparison)

df_time <- data.frame(
  n = c(2000, 10000, 15000, 20000, 40000),
  t = c(1.69, 9.553, 24.96, 42.41, 120.2)
)
ggplot2::qplot(data = df_time, x = df_time$n, y = df_time$t)

comparison <- analysis_richel(
  df_species_trees = df_species_trees,
  df_posterior = df_posterior
)

write.csv(
  x = comparison,
  file = "femke.csv",
  row.names = TRUE
)


#let's plot this

ggplot2::ggplot(
  data = comparison, ggplot2::aes(comparison$diff)
) + ggplot2::geom_histogram(binwidth = 0.1)


