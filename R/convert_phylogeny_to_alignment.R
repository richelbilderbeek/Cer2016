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
  if (!is_phylogeny(phylogeny)) {
    stop(
      "convert_phylogeny_to_alignment: ",
      "parameter 'phylogeny' must be a phylogeny"
    )
  }
  if (sequence_length < 1) {
    stop(
      "convert_phylogeny_to_alignment: ",
      "parameter 'sequence_length' must be a non-zero and positive integer value"
    )
  }
  if (mutation_rate < 0) {
    stop(
      "convert_phylogeny_to_alignment: ",
      "parameter 'mutation_rate' must be a non-zero and positive value"
    )
  }

  alignment_phydat <- simSeq(
    phylogeny,
    l = sequence_length,
    rate = mutation_rate
  )
  testit::assert(class(alignment_phydat)=="phyDat")

  alignment_dnabin <- as.DNAbin(alignment_phydat)
  testit::assert(is_alignment(alignment_dnabin))

  return (alignment_dnabin)
}