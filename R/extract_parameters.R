#' Extract the ERG ('Extinction Rate of a Good species')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the ERG parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   erg <- extract_erg(file)
#'   testit::assert(erg >= 0.0)
#' @author Richel Bilderbeek
extract_erg <- function(file) {
  erg <- NA
  if ("erg" %in% names(file$parameters)) {
    erg <- as.numeric(file$parameters$erg[2])
  }
  if ("extinction_rate_good_species" %in% names(file$parameters)) {
    erg <- as.numeric(file$parameters$extinction_rate_good_species[2])
  }
  return(erg)
}

#' Extract the ERI ('Extinction Rate of an Incipient species')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the ERI parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   eri <- extract_eri(file)
#'   testit::assert(eri >= 0.0)
#' @author Richel Bilderbeek
extract_eri <- function(file) {
  eri <- NA
  if ("eri" %in% names(file$parameters)) {
    eri <- as.numeric(file$parameters$eri[2])
  }
  if ("extinction_rate_incipient_species" %in% names(file$parameters)) {
    eri <- as.numeric(file$parameters$extinction_rate_incipient_species[2]) # nolint this variable name is so long due to backwards compatibility
  }
  return(eri)
}


#' Extract the SCR ('Speciation Completion Rate')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the SCR parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   scr <- extract_scr(file)
#'   testit::assert(scr >= 0.0)
#' @author Richel Bilderbeek
extract_scr <- function(file) {
  scr <- NA
  if ("scr" %in% names(file$parameters)) {
    scr <- as.numeric(file$parameters$scr[2])
  }
  if ("speciation_completion_rate" %in% names(file$parameters)) {
    scr <- as.numeric(file$parameters$speciation_completion_rate[2])
  }
  return(scr)
}


#' Extract the SIRG ('Speciation Initial Rate of a Good species')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the SIRG parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   sirg <- extract_sirg(file)
#'   testit::assert(sirg >= 0.0)
#' @author Richel Bilderbeek
extract_sirg <- function(file) {
  sirg <- NA
  if ("sirg" %in% names(file$parameters)) {
    sirg <- as.numeric(file$parameters$sirg[2])
  }
  if ("species_initiation_rate_good_species" %in% names(file$parameters)) {
    sirg <- as.numeric(file$parameters$species_initiation_rate_good_species[2]) # nolint this variable name is so long due to backwards compatibility
  }
  return(sirg)
}

#' Extract the SIRI ('Speciation Initial Rate of an Incipient species')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the SIRI parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   siri <- extract_siri(file)
#'   testit::assert(siri >= 0.0)
#' @author Richel Bilderbeek
extract_siri <- function(file) {
  siri <- NA
  if ("siri" %in% names(file$parameters)) {
    siri <- as.numeric(file$parameters$siri[2])
  }
  if ("species_initiation_rate_incipient_species" %in% names(file$parameters)) {
    siri <- as.numeric(
      file$parameters$species_initiation_rate_incipient_species[2] # nolint this variable name is so long due to backwards compatibility
    )
  }
  return(siri)
}
