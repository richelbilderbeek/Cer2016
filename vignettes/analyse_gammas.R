## ------------------------------------------------------------------------
library(Cer2016)

## ----collecting_gammas1--------------------------------------------------
phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
df <- collect_gamma_statistics(phylogenies)
knitr::kable(df)

## ----collecting_gammas2--------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_species_tree_gammas(filename)
testit::assert(names(df) == c("species_tree", "gamma_stat"))
testit::assert(nrow(df) == 2)
knitr::kable(df)

## ----collecting_gammas3--------------------------------------------------
filename <- find_path("toy_example_3.RDa")
df <- collect_posterior_gammas(filename)
testit::assert(names(df) == 
  c("species_tree", "alignment", "beast_run", "gamma_stat")
)
testit::assert(nrow(df) == 80)
knitr::kable(head(df))

## ----collecting_gammas4--------------------------------------------------
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

## ----collecting_gammas5--------------------------------------------------
folder <- "/home/p230198/Peregrine"
all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
df <- collect_files_gammas(head(all_parameter_filenames), verbose = TRUE)
testit::assert(names(df) 
  == c("species_tree_gamma_stats", "posterior_gamma_stats")
)
knitr::kable(df$species_tree_gamma_stats)
knitr::kable(head(df$posterior_gamma_stats))

## ----collecting_gammas6--------------------------------------------------
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

## ----loading_files-------------------------------------------------------
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

## ----plot_gamma1---------------------------------------------------------
ggplot2::ggplot(
  data = df_species_trees, ggplot2::aes(df_species_trees$gamma_stat)) +   
  ggplot2::geom_histogram(binwidth = 1,
                          colour = "#0072B2", fill = "blue") +
  ggplot2::theme(text = ggplot2::element_text(size = 12)) +
  ggplot2::theme(axis.text = ggplot2::element_text(size = 12)) +
  ggplot2::xlab("Gamma Statistic") +
  ggplot2::theme(axis.title.x = ggplot2::element_text(color="forestgreen",
                                             vjust=-0.35)) +
  ggplot2::ylab("Count") +
  ggplot2::theme(axis.title.y = ggplot2::element_text(color="cadetblue" , 
                                             vjust=0.35)) +
  ggplot2::ggtitle("Sampled Trees\n Gamma Statistics") +
  ggplot2::theme(plot.title = ggplot2::element_text(size=12, 
                                  face="bold", 
                                  vjust=1, 
                                  lineheight=1))

## ----plot_gamma2---------------------------------------------------------
ggplot2::ggplot(
  data = df_posterior, ggplot2::aes(df_posterior$gamma_stat)) +     
  ggplot2::geom_histogram(binwidth = 1, 
                          colour = "#0072B2", fill = "blue") + 
  ggplot2::theme(text = ggplot2::element_text(size = 12)) +
  ggplot2::theme(axis.text = ggplot2::element_text(size = 12)) +
  ggplot2::xlab("Gamma Statistic") +
  ggplot2::theme(axis.title.x = ggplot2::element_text(color="forestgreen",
                                             vjust=-0.35)) +
  ggplot2::ylab("Count") +
  ggplot2::theme(axis.title.y = ggplot2::element_text(color="cadetblue" , 
                                             vjust=0.35)) +
  ggplot2::ggtitle("Sampled Trees\n Gamma Statistics") +
  ggplot2::theme(plot.title = ggplot2::element_text(size=12, 
                                  face="bold", 
                                  vjust=1, 
                                  lineheight=1))

## ----interesting_values--------------------------------------------------
counter <- 0
interesting_values <- NULL
for (stat in df_species_trees$gamma_stat){
  counter <- counter + 1
  if ( !is.na(stat) && (stat < -10)){
    interesting_values$filenames  <- c(interesting_values$filenames,
                                       df_species_trees$filenames[counter])
    interesting_values$gamma_stat <- c(interesting_values$gamma_stat, stat)
    interesting_values$treenumber <- c(interesting_values$treenumber,
                                       df_species_trees$species_tree[counter])
  }
}
interesting_values <- data.frame(interesting_values)

## ----table1--------------------------------------------------------------
knitr::kable(interesting_values)

## ----looking_at_outlier--------------------------------------------------
counter    <- 0
outliers   <- NULL
for (posterior in df_posterior$filenames){
  counter  <- counter + 1
  counter2 <- 0
  for (filename in interesting_values$filenames){
    counter2 <- counter2 + 1
    if (posterior == filename){
      outliers$filenames  <- c(outliers$filenames,
                               df_posterior$filenames[counter])
      outliers$gamma_post <- c(outliers$gamma_post,
                               df_posterior$gamma_stat[counter])
      outliers$gamma_int  <- c(outliers$gamma_int,
                               interesting_values$gamma_stat[counter2])
      outliers$treenumber <- c(outliers$treenumber,
                               interesting_values$treenumber[counter2])
    }
  }
}

outliers <- data.frame(outliers)

print(names(outliers))

## ----table2--------------------------------------------------------------
knitr::kable(outliers)

## ----comparison----------------------------------------------------------
comparison  <- NULL
for (stat in head(df_posterior$gamma_stat)){
  counter <- 0
  if (!is.na(stat)){ 
    for (value in head(df_species_trees$gamma_stat)){
      counter <- counter + 1
      if (!is.na(value)){
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

## ----table3--------------------------------------------------------------
knitr::kable(comparison)

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

## ----parameter_check-----------------------------------------------------
na_sample    <- NULL
counter      <- 0
for (stat in df_species_trees$gamma_stat){
  counter <- counter + 1
  if (!is.na(stat)){
    counter2 <- 0
    for (filename in row.names(df_parameters)){
      counter2 <- counter2 + 1
      if (filename == df_species_trees$filenames[counter]){
        na_sample$filenames   <- c(na_sample$filenames,
                                   df_species_trees$filenames[counter])
        na_sample$treenumber  <- c(na_sample$treenumber,
                                   df_species_trees$species_tree[counter])
        na_sample$gamma_stat  <- c(na_sample$gamma_stat, stat)
        na_sample$SIR_GS      <- c(na_sample$SIR_GS,
                   df_parameters$species_initiation_rate_good_species[counter2])
        na_sample$SIR_IS      <- c(na_sample$SIR_IS,
              df_parameters$species_initiation_rate_incipient_species[counter2])
        na_sample$SCR         <- c(na_sample$SCR,
                             df_parameters$speciation_completion_rate[counter2])
        na_sample$EXT_GS      <- c(na_sample$EXT_GS,
                           df_parameters$extinction_rate_good_species[counter2])
        na_sample$EXT_IS      <- c(na_sample$EXT_IS,
                      df_parameters$extinction_rate_incipient_species[counter2])
        na_sample$AGE         <- c(na_sample$AGE, df_parameters$age[counter2])
        na_sample$MUTATIONR   <- c(na_sample$MUTATIONR,
                                   df_parameters$mutation_rate[counter2])
        break
      }
    }
  }
}
na_sample <- data.frame(na_sample)

## ----table4--------------------------------------------------------------
knitr::kable(head(na_sample))

## ----SIR_GS_graph--------------------------------------------------------
ggplot2::qplot(SIR_GS, data = na_sample, binwidth = 0.05, xlim = c(-0.1, 2))
ggplot2::qplot(SIR_IS, data = na_sample, binwidth = 0.05, xlim = c(-0.1, 2))

