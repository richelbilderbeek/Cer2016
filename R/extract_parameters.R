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

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  erg <- NA
  if ("erg" %in% names(file$parameters)) {
    erg <- as.numeric(file$parameters$erg[2])
  }
  if (is.na(erg)) {
    stop("parameter 'erg' absent")
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

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  eri <- NA
  if ("eri" %in% names(file$parameters)) {
    eri <- as.numeric(file$parameters$eri[2])
  }
  if (is.na(eri)) {
    stop("parameter 'eri' absent")
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

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  scr <- NA
  if ("scr" %in% names(file$parameters)) {
    scr <- as.numeric(file$parameters$scr[2])
  }
  if (is.na(scr)) {
    stop("parameter 'scr' absent")
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

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  sirg <- NA
  if ("sirg" %in% names(file$parameters)) {
    sirg <- as.numeric(file$parameters$sirg[2])
  }
  if (is.na(sirg)) {
    stop("parameter 'sirg' absent")
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

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  siri <- NA
  if ("siri" %in% names(file$parameters)) {
    siri <- as.numeric(file$parameters$siri[2])
  }
  if (is.na(siri)) {
    stop("parameter 'siri' absent")
  }
  return(siri)
}

#' Extract the number of alignments per species tree
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the number of alignments per species tree
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   napst <- extract_napst(file)
#'   testit::assert(napst == 1)
#' @author Richel Bilderbeek
extract_napst <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  n_alignments <- NA
  if ("n_alignments" %in% names(file$parameters)) {
    n_alignments <- as.numeric(file$parameters$n_alignments[2])
  }
  if (is.na(n_alignments)) {
    stop("parameter 'n_alignments' absent")
  }
  return(n_alignments)
}

#' Extract the number of posteriors per alignment
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the number of posteriors per alignment
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   nppa <- extract_nppa(file)
#'   testit::assert(nppa == 1)
#' @author Richel Bilderbeek
extract_nppa <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  nppa <- NA
  if ("n_beast_runs" %in% names(file$parameters)) {
    nppa <- as.numeric(file$parameters$n_beast_runs[2])
  }
  if (is.na(nppa)) {
    stop("parameter 'n_beast_runs' absent")
  }
  return(nppa)
}

#' Extract the number of states per posterior
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the number of posteriors per alignment
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   nspp <- extract_nspp(file)
#'   testit::assert(nspp == 10)
#' @author Richel Bilderbeek
extract_nspp <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  nspp <- NA
  if ("nspp" %in% names(file$parameters)) {
    nspp <- as.numeric(file$parameters$nspp[2])
  } else {
    # Backwards compatibility
    if ("mcmc_chainlength" %in% names(file$parameters)) {
      nspp <- as.numeric(file$parameters$mcmc_chainlength[2]) / 1000
    }
  }
  if (is.na(nspp)) {
    stop("parameter 'nspp' absent")
  }
  return(nspp)
}
