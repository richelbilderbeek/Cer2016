#' Adds a pbd_sim result to a file
#' @param filename Parameter filename
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing, modifies the parameter file
#' @examples
#'   # Create a parameter file
#'   filename <- "add_pbd_output_example.RDa"
#'   save_parameters_to_file(
#'     rng_seed = 42,
#'     sirg = 0.5,
#'     siri = 0.5,
#'     scr = 0.5,
#'     erg = 0.5,
#'     eri = 0.5,
#'     age = 5,
#'     mutation_rate = 0.1,
#'     n_alignments = 1,
#'     sequence_length = 10,
#'     nspp = 10,
#'     n_beast_runs = 1,
#'     filename = filename
#'   )
#'
#'   # File does not have an incipient species tree yet
#'   testit::assert(!is_pbd_sim_output(read_file(filename)$pbd_output))
#'
#'   # Add an incipient species tree
#'   add_pbd_output(filename)
#'
#'   # File does have an incipient species tree now
#'   testit::assert(is_pbd_sim_output(read_file(filename)$pbd_output))
#'
#'   # Cleanup
#'   file.remove(filename)
#' @export
#' @author Richel Bilderbeek
add_pbd_output <- function(
  filename,
  verbose = FALSE
) {

  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename)) {
    stop("invalid filename")
  }

  file <- Cer2016::read_file(filename)
  if (Cer2016::is_pbd_sim_output(file$pbd_output)) {
    if (verbose) {
      message("file already has a pbd_output")
    }
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
  # PBD::pbd_sim guarantees to return a tree with two taxa
  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  file$pbd_output <- PBD::pbd_sim(
    parameters,
    age = age,
    soc = 2,
    plotit = FALSE
  )
  testit::assert(length(file$pbd_output$igtree.extant$tip.label) > 0)

  saveRDS(file, file = filename)
}
