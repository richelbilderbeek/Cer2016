#' Adds a pbd_sim result to a file
#' @param filename Parameter filename
#' @return Nothing, modifies the parameter file
#' @export
#' @author Richel Bilderbeek
add_pbd_output <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("add_pbd_output: invalid filename")
  }
  file <- read_file(filename)
  if (is_pbd_sim_output(file$pbd_output)) {
    print(paste("file ",filename," already has a pbd_output",sep = ""))
    return()
  }
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  species_initiation_rate_good_species  <- as.numeric(parameters$species_initiation_rate_good_species[2])
  species_initiation_rate_incipient_species  <- as.numeric(parameters$species_initiation_rate_incipient_species[2])
  speciation_completion_rate <- as.numeric(parameters$speciation_completion_rate[2])
  extinction_rate_good_species <- as.numeric(parameters$extinction_rate_good_species[2])
  extinction_rate_incipient_species <- as.numeric(parameters$extinction_rate_incipient_species[2])
  age <- as.numeric(parameters$age[2])
  set.seed(rng_seed)
  parameters <- c(
    species_initiation_rate_good_species,
    speciation_completion_rate,
    species_initiation_rate_incipient_species,
    extinction_rate_good_species,
    extinction_rate_incipient_species
  )
  #pbd_output <- pbd_sim(c(
  file$pbd_output <- PBD::pbd_sim(
    parameters,
    age = age,
    soc = 2,
    plotit = FALSE
  )
  #phylogeny <- pbd_output$tree
  #file$pbd_output <- pbd_output
  saveRDS(file,file = filename)
  print(paste("Added pbd_output to file ",filename,sep = ""))
}