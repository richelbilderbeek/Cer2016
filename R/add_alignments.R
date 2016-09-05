#' Add an alignment to a file
#' @param filename Parameter filename
#' @return Nothing, modifies the parameter file
#' @examples
#'  # Create a file with parameters
#'  filename <- "add_alignment_example.RDa"
#'  save_parameters_to_file(
#'    rng_seed = 42,
#'    sirg = 0.5,
#'    siri = 0.5,
#'    scr = 0.5,
#'    erg = 0.5,
#'    eri = 0.5,
#'    age = 5,
#'    mutation_rate = 0.1,
#'    n_alignments = 1,
#'    sequence_length = 10,
#'    nspp = 10,
#'    n_beast_runs = 1,
#'    filename = filename
#'  )
#'
#'  # Add an incipient species tree
#'  add_pbd_output(filename)
#'
#'  # Add the sampled species trees
#'  add_species_trees(filename = filename)
#'
#'  # Test if there are no alignments yet
#'  testit::assert(
#'    has_alignments(read_file(filename = filename))
#'    == rep(FALSE, times = 2)
#'  )
#'
#'  # Add the alignments (n_alignments per species tree)
#'  add_alignments(filename = filename)
#'
#'  # Test if there are alignments now
#'  testit::assert(
#'    has_alignments(read_file(filename = filename))
#'    == rep(TRUE, times = 2)
#'  )
#'
#'  # Cleanup
#'  file.remove(filename)
#' @export
#' @author Richel Bilderbeek
add_alignments <- function(filename) {
  if (!is_valid_file(filename)) {
    stop("invalid file")
  }
  file <- Cer2016::read_file(filename)
  for (sti in 1:2) {
    species_tree <- NA
    tryCatch(
      species_tree <- get_species_tree_by_index(file = file, sti = sti),
      error = function(msg) {
        stop("need species_trees at index ", sti)
      }
    )
    testit::assert(Cer2016::is_phylogeny(species_tree))
  }

  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  testit::assert(n_alignments > 0)
  sequence_length <- as.numeric(parameters$sequence_length[2])
  testit::assert(length(file$alignments) == n_alignments * 2)


  for (sti in 1:2) {
    species_tree <- Cer2016::get_species_tree_by_index(file = file, sti = sti)
    testit::assert(!is.na(species_tree))
    for (ai in 1:n_alignments) {
      # Alignments must be different, even if species trees (oldest
      # and youngest) are identical
      this_seed <- rng_seed + a2i(sti = sti, ai = ai, nstpist = 2, napst = n_alignments) # nolint
      set.seed(this_seed)

      # Simulate alignment on phylogeny
      alignment <- convert_phylogeny_to_alignment(
        phylogeny = species_tree,
        sequence_length = sequence_length,
        mutation_rate = mutation_rate
      )

      # Save alignment
      file <- set_alignment(
        file = file,
        sti = sti,
        ai = ai,
        alignment = alignment
      )
      saveRDS(object = file, file = filename)
    }
  }

  # Postconditions
  testit::assert(Cer2016::has_alignments(file))
}
