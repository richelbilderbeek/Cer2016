#' Add BEAST2 posteriors to a file
#' @param filename Parameter filename
#' @return Nothing, modifies the parameter file
#' @export
#' @author Richel Bilderbeek
add_posteriors <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("add_posteriors: invalid filename")
  }
  file <- read_file(filename)
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  mcmc_chainlength <- as.numeric(parameters$mcmc_chainlength[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  n_beast_runs <- as.numeric(parameters$n_beast_runs[2])
  n_species_trees_samples <- as.numeric(
    file$parameters$n_species_trees_samples[2]
  )
  for (i in seq(1, n_species_trees_samples)) {
    for (j in seq(1, n_alignments)) {
      alignment_index <- 1 + (j - 1) + ((i - 1) * n_species_trees_samples)      # nolint
      testit::assert(alignment_index >= 1 &&
        alignment_index <= length(file$alignments)
      )
      alignment <- file$alignments[[alignment_index]][[1]]
      testit::assert(is_alignment(alignment))
      for (k in seq(1, n_beast_runs)) {
        posterior_index <- 1 + (k - 1) +
          ((j - 1) * n_alignments) +                                            # nolint
          ((i - 1) * n_alignments * n_species_trees_samples)                    # nolint
        testit::assert(posterior_index >= 1 &&
          posterior_index <= length(file$posteriors)
        )
        if (is_beast_posterior(file$posteriors[[posterior_index]][[1]])) {
          print(paste("   * Posterior #", k, " for alignment #",
            j," for species tree #", i," at posterior_index #",
            posterior_index, " already has a posterior", sep = "")
          )
          next
        }
        new_seed <- rng_seed + k
        print(paste("   * Setting seed to ", new_seed, sep = ""))
        set.seed(new_seed)
        basefilename <- paste(basename(
          tools::file_path_sans_ext(filename)), "_",
          i, "_", j, "_", k, sep = ""
        )
        posterior <- convert_alignment_to_beast_posterior(
          alignment_dnabin = alignment,
          base_filename = basefilename,
          mcmc_chainlength = mcmc_chainlength,
          rng_seed = new_seed
        )
        print(paste("   * Storing posterior #", k,
          " for alignment #", j, " for species tree #", i,
          " at posterior_index #", posterior_index, sep = "")
        )
        file$posteriors[[posterior_index]] <- list(posterior)
      }
    }
  }
  saveRDS(file, file = filename)
  print(paste("file ", filename, " has gotten its posteriors", sep = ""))
}
