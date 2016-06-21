#' Add an alignment to a file
#' @param filename Parameter filename
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing, modifies the parameter file
#' @export
#' @author Richel Bilderbeek
add_alignments <- function(
  filename,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "add_alignments: ",
      "verbose should be TRUE or FALSE"
    )
  }
  if (!is_valid_file(filename)) {
    stop("add_alignments: invalid file")
  }
  file <- Cer2016::read_file(filename)

  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  testit::assert(n_alignments > 0)
  sequence_length <- as.numeric(parameters$sequence_length[2])
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])
  testit::assert(length(file$alignments) ==
    n_alignments * n_species_trees_samples
  )

  testit::assert(length(n_species_trees_samples) == n_species_trees_samples)
  for (species_tree_index in seq(1, n_species_trees_samples)) {
    if (is.na(file$species_trees_with_outgroup[species_tree_index])) {
      stop(
        "add_alignments: need species_trees_with_outgroup at index ",
        species_tree_index
      )
    }
  }

  for (i in seq(1, n_species_trees_samples)) {
    species_tree <- file$species_trees_with_outgroup[[i]][[1]]
    testit::assert(!is.na(species_tree))
    for (j in seq(1, n_alignments)) {
      index <- 1 + (j - 1) + ((i - 1) * n_species_trees_samples)                # nolint
      if (class(file$alignments[[index]][[1]]) == "DNAbin") {
        if (verbose) {
          message("add_alignments: already got alignment #", j,
            " for species tree #", i, " at index #", index
          )
        }
        next
      }
      new_seed <- rng_seed - 1 + j + ((i - 1) * n_species_trees_samples)        # nolint
      set.seed(new_seed)
      alignment <- convert_phylogeny_to_alignment(
        phylogeny = species_tree,
        sequence_length = sequence_length,
        mutation_rate = mutation_rate
      )
      file$alignments[[index]] <- list(alignment)
      saveRDS(file, file = filename)
      if (verbose) {
        message("add_alignments: created and saved alignments[", index, "]")
      }
    }
  }
  if (verbose) {
    message("file ", filename, " has gotten its ", n_alignments,
      " alignments (per species tree)"
    )
  }
}
