#' Collect posterior filenames
#' @param filename Parameter filename
#' @return generates species tree files from the posterior
#' @export
#' @examples
#'   parameter_filename <- find_path("toy_example_1.RDa")
#'   posterior_filenames <- collect_posterior_filenames(parameter_filename)
#'   trees_filename <- find_path("toy_example_1_1_1_1.trees")
#'   assert(length(posterior_filenames) == 1)
#'   assert(length(posterior_filenames[1]) == trees_filename)
#' @author Richel Bilderbeek and Jolien Gay
collect_posterior_filenames <- function(
  parameter_filename
) {
  if (length(parameter_filename) != 1) {
    stop("collect_posterior_filenames: ",
         "must supply one filename"
    )
  }
  if (!file.exists(parameter_filename)) {
    stop("collect_posterior_filenames: ",
    "file '", parameter_filename, "' does not exist"
    )
  }
  if (!is_valid_file(parameter_filename)) {
    stop("collect_posterior_filenames: ",
         "file '", parameter_filename, "' is invalid"
    )
  }
  base_filename <- tools::file_path_sans_ext(parameter_filename)
  file <- read_file(parameter_filename)
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
  # Posterior nLTT values
  trees_filenames <- NULL

  for (i in seq(1, n_species_trees_samples)) {
    for (j in seq(1, n_alignments)) {
      for (k in seq(1, n_beast_runs)) {
        trees_filename <- paste(
          base_filename, "_", i, "_", j, "_", k, ".trees", sep = ""
        )
        if (!file.exists(trees_filename)) {
          print(paste("File '", trees_filename, "' not found", sep = ""))
          next
        }
        trees_filenames <- c(trees_filenames, trees_filename)
      }
    }
  }
  return(trees_filenames)
}
