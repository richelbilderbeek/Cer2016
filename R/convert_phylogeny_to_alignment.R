#' Converts a phylogeny to a random DNA alignment
#' @param phylogeny a phylogeny
#' @param sequence_length the number of nucleotides to alignment
#'   will have per taxon
#' @param mutation_rate the rate per nucleotide to change,
#'   per million years
#' @return an alignment
#' @export
#' @author Richel Bilderbeek
convert_phylogeny_to_alignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) {
  # Convert a phylogeny to a random DNA alignment

  assert(is_phylogeny(phylogeny))
  assert(sequence_length > 0)
  assert(mutation_rate >= 0)

  alignment_phydat <- simSeq(
    phylogeny,
    l = sequence_length,
    rate = mutation_rate
  )
  assert(class(alignment_phydat)=="phyDat")

  alignment_dnabin <- as.DNAbin(alignment_phydat)
  assert(is_alignment(alignment_dnabin))

  return (alignment_dnabin)
}