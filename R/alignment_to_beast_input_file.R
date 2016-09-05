#' Convert an alignment and parameters to a BEAST XML input file
#' @param alignment_dnabin the DNA alignment of type DNAbin
#' @param nspp the number of states in a BEAST2 MCMC chain,
#'   typically there is one state per one thousand generations
#' @param rng_seed random number generator seed
#' @param beast_filename the filename of the XML BEAST2 input file created
#' @param temp_fasta_filename the name of a temporary file created
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing, creates a file called 'beast_filename'
#' @examples
#'
#'   # Simulate a phylogeny
#'   phylogeny <- ape::rcoal(n = 5)
#'
#'   # Simulate an alignment from that phylogeny
#'   alignment <- convert_phylogeny_to_alignment(
#'     phylogeny = phylogeny,
#'     sequence_length = 10
#'   )
#'
#'   # Create a BEAST2 input file
#'   beast_xml_input_file <- "alignment_to_beast_input_file_example.xml"
#'   fasta_filename <- "alignment_to_beast_input_file_examp.fasta"
#'   alignment_to_beast_input_file(
#'     alignment_dnabin = alignment,
#'     nspp = 10,
#'     rng_seed = 42,
#'     beast_filename = beast_xml_input_file,
#'     temp_fasta_filename = fasta_filename
#'   )
#'
#'   # Check that the BEAST2 input file really exists
#'   testit::assert(file.exists(beast_xml_input_file))
#'
#' @export
#' @author Richel Bilderbeek
alignment_to_beast_input_file <- function(
  alignment_dnabin,
  nspp,
  rng_seed = 42,
  beast_filename,
  temp_fasta_filename,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop(
      "alignment_to_beast_input_file: ",
      "verbose should be TRUE or FALSE"
    )
  }
  # Save to FASTA file
  Cer2016::convert_alignment_to_fasta(alignment_dnabin, temp_fasta_filename)

  # So that mcmc_chainlength is written as 1000000 instead of 1e+7
  options(scipen = 20)
  beastscriptr::beast_scriptr(
    input_fasta_filename = temp_fasta_filename,
    mcmc_chainlength = nspp * 1000,
    tree_prior = "birth_death",
    date_str = "20151027",
    output_xml_filename = beast_filename
  )

  testit::assert(file.exists(beast_filename))
  file.remove(temp_fasta_filename)
  testit::assert(!file.exists(temp_fasta_filename))

}
