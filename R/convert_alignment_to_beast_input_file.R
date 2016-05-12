#' Convert an alignment and parameters to a BEAST XML input file
#' @param alignment_dnabin the DNA alignment of type DNAbin
#' @param mcmc_chainlength the BEAST2 MCMC chain length
#' @param rng_seed random number generator seed
#' @param beast_filename the filename of the XML BEAST2 input file created
#' @param temp_fasta_filename the name of a temporary file created
#' @return Nothing, creates a file called 'beast_filename'
#' @export
#' @author Richel Bilderbeek
convert_alignment_to_beast_input_file <- function(
  alignment_dnabin,
  mcmc_chainlength,
  rng_seed = 42,
  beast_filename,
  temp_fasta_filename
) {
  # Reads an alignment (a FASTA file) and with some
  # additional parameters create a BEAST2 XML input file
  #beastscriptr::beast_scriptr(

  # Choose the fastest, iff present
  # Reads an alignment (a FASTA file) and with some
  # additional parameters create a BEAST2 XML input file
  # using the R script version of BeastScripter

  # Save to FASTA file
  convert_alignment_to_fasta(alignment_dnabin, temp_fasta_filename)

  # So that mcmc_chainlength is written as 1000000 instead of 1e+7
  options(scipen = 20)
  beastscriptr::beast_scriptr(
    input_fasta_filename = temp_fasta_filename,
    mcmc_chainlength = mcmc_chainlength,
    tree_prior = "birth_death",
    date_str = "20151027",
    output_xml_filename = beast_filename
  )

  testit::assert(file.exists(beast_filename))
  file.remove(temp_fasta_filename)
  testit::assert(!file.exists(temp_fasta_filename))

}
