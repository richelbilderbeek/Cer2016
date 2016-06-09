#' Add a species tree with/without outgroup to a file
#' @param filename Parameter filename
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing, modifies the parameter file
#' @export
#' @author Richel Bilderbeek
add_species_trees <- function(
  filename,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "add_species_trees: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename)) {
    stop("add_species_trees: invalid file")
  }
  file <- Cer2016::read_file(filename)
  if (is.na(file$pbd_output[1])) {
    stop("add_species_trees: ",
      "file '", filename, "' needs a pbd_output"
    )
  }
  parameters <- file$parameters
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])
  rng_seed <- as.numeric(parameters$rng_seed[2])
  if (verbose) {
    print(paste("Adding species_trees_with_outgroup to file ",
      filename, sep = "")
    )
  }

  for (i in seq(1:n_species_trees_samples)) {
    if (!is.na(file$species_trees_with_outgroup[i]) && verbose) {
        print(paste0(" * species_trees_with_outgroup[", i, "] already exists")
      )
      next
    }
    if (verbose) print(paste0("   * Setting seed to ", (rng_seed + i)))
    # Each species tree is generated from its own RNG seed
    set.seed(rng_seed + i)
    species_tree <- sample_species_trees(
      n = 1, file$pbd_output
    )[[1]]
    testit::assert(class(species_tree) == "phylo")
    file$species_trees_with_outgroup[[i]] <- list(species_tree)
    saveRDS(file, file = filename)
  }
  if (verbose) {
    print(paste0("Added species_trees_with_outgroup to file ", filename))
  }
}
