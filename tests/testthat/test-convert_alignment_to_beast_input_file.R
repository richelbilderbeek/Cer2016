context("alignment_to_beast_input_file")

test_that("creates an XML", {

  phylogeny_without_outgroup <- ape::rcoal(n = 5)

  phylogeny_with_outgroup <- add_outgroup_to_phylogeny(
    phylogeny_without_outgroup,
    stem_length = 0
  )
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny_with_outgroup,
    sequence_length = 10
  )

  beast_xml_input_file <- "test-alignment_to_beast_input_file.xml"
  fasta_filename <- "test-alignment_to_beast_input_file.fasta"

  alignment_to_beast_input_file(
    alignment_dnabin = alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42,
    beast_filename = beast_xml_input_file,
    temp_fasta_filename = fasta_filename
  )
  expect_true(file.exists(beast_xml_input_file))

  # Clean up: remove the temporary files
  file.remove(beast_xml_input_file)
  expect_true(!file.exists(beast_xml_input_file))
})
