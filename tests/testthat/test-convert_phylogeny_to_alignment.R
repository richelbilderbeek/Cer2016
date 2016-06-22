context("convert_phylogeny_to_alignment")

test_that("convert_phylogeny_to_alignment: basic", {
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = ape::rcoal(5),
    sequence_length = 10,
    mutation_rate = 1
  )
  expect_true(is_alignment(alignment))
})

test_that("convert_phylogeny_to_alignment: abuse", {
  expect_error(
    convert_phylogeny_to_alignment(
      phylogeny = "not a phylogeny",
      sequence_length = 10,
      mutation_rate = 1
    ),
    "convert_phylogeny_to_alignment: parameter 'phylogeny' must be a phylogeny" #nolint
  )

  expect_error(
    convert_phylogeny_to_alignment(
      phylogeny = ape::rcoal(5),
      sequence_length = -1, # Must be positive
      mutation_rate = 1
    ),
    "convert_phylogeny_to_alignment: parameter 'sequence_length' must be a non-zero and positive integer value" # nolint
  )

  expect_error(
    convert_phylogeny_to_alignment(
      phylogeny = ape::rcoal(5),
      sequence_length = 10,
      mutation_rate = -1 # Must be positive
    ),
    "convert_phylogeny_to_alignment: parameter 'mutation_rate' must be a non-zero and positive value" # nolint
  )
})
