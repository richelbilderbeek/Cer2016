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
    print(paste("file ", filename, " already has a pbd_output", sep = ""))
    return()
  }
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  sirg  <- as.numeric(parameters$sirg[2])
  siri  <- as.numeric(parameters$siri[2])
  scr <- as.numeric(parameters$scr[2])
  erg <- as.numeric(parameters$erg[2])
  eri <- as.numeric(parameters$eri[2])
  age <- as.numeric(parameters$age[2])
  set.seed(rng_seed)
  parameters <- c(
    sirg,
    scr,
    siri,
    erg,
    eri
  )

  # Must get an incipient species tree with at least one taxon
  while (1) {
    file$pbd_output <- PBD::pbd_sim(
      parameters,
      age = age,
      soc = 2,
      plotit = FALSE
    )
    n_taxa <- length(file$pbd_output$igtree.extant$tip.label)
    if (n_taxa > 0) {
      break
    } else {
      print("n_taxa is 0")
    }
  }
  testit::assert(length(file$pbd_output$igtree.extant$tip.label) > 0)
  saveRDS(file, file = filename)
}