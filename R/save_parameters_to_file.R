#' Creates a valid parameter file
#' @param rng_seed the random number generator seed
#' @param sirg the species initiation rate of the good species
#' @param siri the speciation-initiation rate of the incipient species
#' @param scr the rate at which incipient species become good
#' @param erg the rate at which good species get extinct
#' @param eri the rate at which incipient species get extinct
#' @param age crown age of the phylogeny
#' @param n_species_trees_samples the number of species trees that will be sampled from an incipient species tree
#' @param add_outgroup must an outgroup be added before simulating a DNA sequence on the sampled species trees? Must be TRUE or FALSE
#' @param mutation_rate the probability per nucleotide to mutate at a DNA replication
#' @param n_alignments the number of alignments simulated per species tree
#' @param sequence_length the simulated DNA sequence length in nucleotides
#' @param mcmc_chainlength the length of the MCMC chain that BEAST2 will run
#' @param n_beast_runs the number of BEAST2 runs per DNA alignments
#' @param filename the name of the parameter file that will be created by this function
#' @return Nothing, it will create a file with filename `filename`
#' @examples
#' filename <- "save_parameters_to_file_example.RDa"
#' save_parameters_to_file(
#'   rng_seed = 42,
#'   sirg = 0.5,
#'   siri = 0.5,
#'   scr = 0.5,
#'   erg = 0.5,
#'   eri = 0.5,
#'   age = 5,
#'   n_species_trees_samples = 1,
#'   add_outgroup = TRUE,
#'   mutation_rate = 0.1,
#'   n_alignments = 1,
#'   sequence_length = 10,
#'   mcmc_chainlength = 10000,
#'   n_beast_runs = 1,
#'   filename = filename
#' )
#' testit::assert(is_valid_file(filename) == TRUE)
#' @export
#' @author Richel Bilderbeek
save_parameters_to_file <- function(
  rng_seed,
  sirg,
  siri,
  scr,
  erg,
  eri,
  age,
  n_species_trees_samples,
  add_outgroup,
  mutation_rate,
  n_alignments,
  sequence_length,
  mcmc_chainlength,
  n_beast_runs,
  filename
) {
  if (add_outgroup != TRUE && add_outgroup != FALSE) {
    stop(
      "save_parameters_to_file: ",
      "add_outgroup must be either TRUE or FALSE"
    )
  }
  my_table <- data.frame( row.names = c("Description", "Value"))
  my_table[, "rng_seed"] <- c(
    "Random number generate seed", rng_seed
  )
  my_table[, "sirg"] <- c(
    "species initiation rate good species", sirg
  )
  my_table[, "siri"] <- c(
    "species initiation rate incipient species", siri
  )
  my_table[, "scr"] <- c(
    "speciation_completion_rate", scr
  )
  my_table[, "erg"] <- c(
    "extinction_rate_good_species", erg
  )
  my_table[, "eri"] <- c(
    "extinction_rate_incipient_species", eri
  )
  my_table[, "age"] <- c(
    "Phylogenetic tree crown age", age
  )
  my_table[, "n_species_trees_samples"] <- c(
    "species trees sampled", n_species_trees_samples
  )
  my_table[, "add_outgroup"] <- c(
    "outgroup added", add_outgroup
  )
  my_table[, "mutation_rate"] <- c(
    "DNA mutation rate", mutation_rate
  )
  my_table[, "n_alignments"] <- c(
    "Number of DNA alignments per species tree", n_alignments
  )
  my_table[, "sequence_length"] <- c(
    "DNA sequence length", sequence_length
  )
  my_table[, "mcmc_chainlength"] <- c(
    "MCMC chain length", mcmc_chainlength
  )
  my_table[, "n_beast_runs"] <- c(
    "Number of BEAST2 runs per alignment", n_beast_runs
  )
  my_table[, "version"] <- c("Parameter file version", "0.1")
  # Create the slots for the results
  my_list <- list(
    my_table, #parameters
    NA, # pbd_output
    # species_trees_with_outgroup
    rep(x = NA, times = n_species_trees_samples),
    # alignments
    rep(x = NA, times = n_species_trees_samples * n_alignments),
    # posteriors
    rep(x = NA, times = n_species_trees_samples * n_alignments * n_beast_runs)
  )
  names(my_list) <- c(
      "parameters", "pbd_output",
      "species_trees_with_outgroup", "alignments", "posteriors"
    )
  testit::assert(length(my_list$pbd_output) == 1)
  testit::assert(length(my_list$species_trees_with_outgroup)
    == n_species_trees_samples
  )
  testit::assert(length(my_list$alignments)
    == n_species_trees_samples * n_alignments
  )
  testit::assert(length(my_list$posteriors)
    == n_species_trees_samples * n_alignments * n_beast_runs
  )
  saveRDS(my_list, file = filename)
}
