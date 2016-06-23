#' Creates the parameter files for the toy examples
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_test_parameter_files <- function(
  filenames = paste0("toy_example_", seq(1,4), ".RDa")
) {
  if (length(filenames) != 4) {
    stop(
      "create_test_parameter_files: must have exactly four filenames"
    )
  }
  rng_seeds <- seq(1, 4)
  sirgs <- rep(0.5, times = 4)
  siris <- rep(0.5, times = 4)
  scrs <- c(1.0e6, 1.0e-1, 1.0e6, 1.0e-1)
  ergs <- rep(0.1, times = 4)
  eris <- rep(0.1, times = 4)
  ages <- rep(5, times = 4)
  n_species_trees_sampleses <- c(1, 1, 2, 2)
  mutation_rates <- rep(0.01, times = 4)
  n_alignmentses <- c(1, 1, 2, 2)
  sequence_lengths <- rep(1000, times = 4)
  mcmc_chainlengths <- rep(10000, times = 4)
  n_beast_runses <- c(1, 1, 2, 2)
  for (i in seq(1, 4)) {
    save_parameters_to_file(
      rng_seed = rng_seeds[i],
      sirg = sirgs[i],
      siri = siris[i],
      scr = scrs[i],
      erg = ergs[i],
      eri = eris[i],
      age = ages[i],
      n_species_trees_samples = n_species_trees_sampleses[i],
      mutation_rate = mutation_rates[i],
      n_alignments = n_alignmentses[i],
      sequence_length = sequence_lengths[i],
      mcmc_chainlength = mcmc_chainlengths[i],
      n_beast_runs = n_beast_runses[i],
      filename = filenames[i]
    )
  }
  filenames
}
