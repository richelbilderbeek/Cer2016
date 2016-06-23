#' Convert an alignment (of type DNAbin) to a FASTA file
#' @param alignment_dnabin DNA alignment of type DNAbin
#' @param filename FASTA filename the alignment will be saved to
#' @return Nothing, it will create a FASTA file
#' @export
#' @author Richel Bilderbeek
convert_alignment_to_fasta <- function(
  alignment_dnabin,
  filename
) {
  # Create a FASTA file text from an alignment
  if (!class(alignment_dnabin) == "DNAbin") {
    stop(
      "convert_alignment_to_fasta: alignment_dnabin must be of class DNAbin"
    )
  }
  phangorn::write.phyDat(alignment_dnabin, file = filename, format = "fasta")
}
