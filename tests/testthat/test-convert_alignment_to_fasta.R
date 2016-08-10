context("convert_alignment_to_fasta")

test_that("convert_alignment_to_fasta: use", {
  expect_equal(2 * 2, 4)
})

test_that("convert_alignment_to_fasta: abuse", {
  expect_error(
    convert_alignment_to_fasta(
      alignment_dnabin = "invalid",
      filename = "test-convert_alignment_to_fasta.fasta"
    ),
    "alignment_dnabin must be of class DNAbin"
  )
})
