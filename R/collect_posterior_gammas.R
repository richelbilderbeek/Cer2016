#' Collect the gamma statistics of the BEAST2 posteriors
#' @param filename name of the file containing the parameters and results
#' @return a data frame
#' @export
#' @examples
#'   filename <- find_path("toy_example_3.RDa")
#'   df <- collect_posterior_gammas(filename)
#'   testit::assert(names(df) ==
#'     c("species_tree", "alignment", "beast_run", "gamma_stat")
#'   )
#'   testit::assert(nrow(df) == 80)
#' @author Richel Bilderbeek
collect_posterior_gammas <- function(filename) {
  if (!is_valid_file(filename)) {
    stop(
      "collect_posterior_gammas: ",
      "invalid filename"
    )
  }
  file <- Cer2016::read_file(filename)
  parameters <- file$parameters
  n_alignments <- as.numeric(parameters$n_alignments[2])
  n_beast_runs <- as.numeric(parameters$n_beast_runs[2])
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )

  df <- NULL
  index <- 1

  for (i in seq(1, n_species_trees_samples)) {
    for (j in seq(1, n_alignments)) {
      for (k in seq(1, n_beast_runs)) {
        phylogenies <- Cer2016::extract_posteriors(file)[[1]][[index]]
        gamma_statistics <- Cer2016::collect_gamma_statistics(phylogenies)

        # Remove id column
        gamma_statistics <- subset(
          gamma_statistics,
          select = -c(id) # nolint Putting 'gamma_statistics$' before ID will break the code
        )
        testit::assert(!is.null(gamma_statistics$gamma))

        n_gamma_statistics <- nrow(gamma_statistics)
        this_df <- data.frame(
          species_tree = rep(i, n_gamma_statistics),
          alignment = rep(j, n_gamma_statistics),
          beast_run = rep(k, n_gamma_statistics)
        )
        this_df <- cbind(this_df, gamma_statistics)
        if (is.null(df)) {
          df <- this_df
        } else {
          df <- rbind(df, this_df)
        }
        index <- index + 1
      }
    }
  }
  testit::assert(!is.null(df$gamma))
  df
}
