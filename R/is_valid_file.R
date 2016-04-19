#' Checks if a file is a valid parameter file
#' @param filename the name of the file to be checked
#' @return TRUE or FALSE
#' @export
is_valid_file <- function(filename) {
  if (!file.exists(filename)) return(FALSE)
  file <- read_file(filename)
  if (mode(file) != "list") return(FALSE)
  if (is.null(file$parameters)) return(FALSE)
  if (is.null(file$pbd_output)) return(FALSE)
  if (is.null(file$species_trees_with_outgroup)) return(FALSE)
  if (is.null(file$alignments)) return(FALSE)
  if (is.null(file$posteriors)) return(FALSE)
  parameters <- file$parameters
  if (as.numeric(parameters$sirg[2]) < 0.0) return(FALSE)
  if (as.numeric(parameters$siri[2]) < 0.0) return(FALSE)
  if (as.numeric(parameters$scr[2]) < 0.0) return(FALSE)
  if (as.numeric(parameters$erg[2]) < 0.0) return(FALSE)
  if (as.numeric(parameters$eri[2]) < 0.0) return(FALSE)
  if (as.numeric(parameters$age[2]) <= 0.0) return(FALSE)
  if (as.numeric(parameters$n_species_trees_samples[2]) < 1) return(FALSE)
  if (as.numeric(parameters$mutation_rate[2]) <= 0.0) return(FALSE)
  if (as.numeric(parameters$n_alignments[2]) < 1) return(FALSE)
  if (as.numeric(parameters$sequence_length[2]) < 1) return(FALSE)
  if (as.numeric(parameters$n_beast_runs[2]) < 1) return(FALSE)
  if (as.numeric(parameters$mcmc_chainlength[2]) < 1) return(FALSE)
  return(TRUE)
}