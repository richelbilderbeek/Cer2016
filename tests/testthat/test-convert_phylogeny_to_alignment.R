context("convert_phylogeny_to_alignment")

test_that("convert_phylogeny_to_alignment: basic", {
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = ape::rcoal(5),
    sequence_length = 10,
    mutation_rate = 1
  )
  expect_equal(is_alignment(alignment), TRUE)
})
