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
  testit::assert(length(file$alignments) == n_alignments * 2)

  for (sti in 1:2) {
    species_tree <- NA
    tryCatch(
      species_tree <- get_species_tree_by_index(file = file, sti = sti),
      error = function(msg) {}
    )
    if (!is_phylogeny(species_tree)) {
      stop("add_alignments: need species_trees at index ", sti)
    }
  }

  for (i in 1:2) {
    species_tree <- get_species_tree_by_index(file = file, sti = sti)
    testit::assert(!is.na(species_tree))
    for (j in seq(1, n_alignments)) {
      index <- 1 + (sti - 1) + ((j - 1) * 2)
      alignment <- NA
      tryCatch(
        alignment <- get_alignment_by_index(file = file, alignment_index = index),
        error = function(msg) {}
      )
      if (is_alignment(alignment)) {
        if (verbose) {
          message("add_alignments: already got alignment #", j,
            " for species tree #", sti, " at index #", index
          )
        }
        next
      }
      new_seed <- rng_seed - 1 + j + ((sti - 1) * 2)
      set.seed(new_seed)
      alignment <- convert_phylogeny_to_alignment(
        phylogeny = species_tree,
        sequence_length = sequence_length,
        mutation_rate = mutation_rate
      )
      file <- set_alignment_by_index(
        file = file,
        alignment_index = index,
        alignment = alignment
      )
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
