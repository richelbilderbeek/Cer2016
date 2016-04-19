convert_alignment_to_fasta <- function(
  alignment_dnabin,
  filename
) {
  # Create a FASTA file text from an alignment
  if (!class(alignment_dnabin) == "DNAbin") {
    stop("alignment_dnabin: alignment must be of class DNAbin")
  }
  phangorn::write.phyDat(alignment_dnabin, file = filename, format = "fasta")
}