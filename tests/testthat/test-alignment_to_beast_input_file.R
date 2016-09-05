context("alignment_to_beast_input_file")

test_that("creates an XML", {

  phylogeny <- ape::rcoal(n = 5)

  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny,
    sequence_length = 10
  )

  beast_xml_input_file <- "test-alignment_to_beast_input_file.xml"
  fasta_filename <- "test-alignment_to_beast_input_file.fasta"

  alignment_to_beast_input_file(
    alignment_dnabin = alignment,
    nspp = 10,
    rng_seed = 42,
    beast_filename = beast_xml_input_file,
    temp_fasta_filename = fasta_filename
  )
  expect_true(file.exists(beast_xml_input_file))

  # Clean up: remove the temporary files
  file.remove(beast_xml_input_file)
  expect_true(!file.exists(beast_xml_input_file))
})


test_that("alignment_to_beast_input_file: abuse", {

  expect_error(
    alignment_to_beast_input_file(
      alignment_dnabin = "",
      nspp = 1,
      rng_seed = 42,
      beast_filename = "",
      temp_fasta_filename = "",
      verbose = "not TRUE nor FALSE"
    ),
    "verbose should be TRUE or FALSE"
  )
})
