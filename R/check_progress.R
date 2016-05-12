#' Function that shows how much parameter files are present,
#' and how far the pipeline has gotten
#' @param folder The folder containing the parameter files
#' @return A data table showing the progress
#' @export
#' @author Richel Bilderbeek
check_progress <- function(
  folder = "."
) {
  filenames <- list.files(path = folder, pattern = ".RDa")
  n_files <- length(filenames)
  if (n_files == 0) {
    df <- data.frame(
      filenames = c("none"),
      progress = c("NA")
    )
    return(df)
  }

  df <- data.frame(
    files = filenames,
    has_pbd_sim_output = rep("?", length(n_files)),
    n_species_trees_sampled = rep("?", length(n_files)),
    stringsAsFactors = FALSE
  )

  for (i in seq(1, n_files)) {
    my_file <- read_file(filenames[i])
    df$has_pbd_sim_output[i] <- ifelse(
      is_pbd_sim_output(my_file$pbd_output), "yes", "no"
    )
    n_species_trees_samples <- as.numeric(
      my_file$parameters$n_species_trees_samples[2]
    )
    n_species_trees_sampled <- 0
    for (j in seq(1, n_species_trees_samples)) {
      if (!is.na(my_file$species_trees_with_outgroup[i])) {
        n_species_trees_sampled <- n_species_trees_sampled + 1
      }
    }
    df$n_species_trees_sampled[i] <- paste(n_species_trees_sampled,
      "/", n_species_trees_samples, sep = "")
  }

  df
}
