context("is_alignment")

test_that("basic tests", {
  alignment_a <- create_random_alignment(n_taxa = 5, sequence_length = 10)
  alignment_b <- create_random_alignment(n_taxa = 2, sequence_length = 1)

  expect_true(is_alignment(alignment_a))
  expect_true(is_alignment(alignment_b))
  #assert(!is_alignment(c(alignment_a,alignment_a))) # DNAbin forbids this
  #assert(!is_alignment(c(alignment_b,alignment_b))) # DNAbin forbids this
  expect_true(!is_alignment(list(alignment_a,alignment_a)))
  expect_true(!is_alignment(rmtree(N = 2, n = 10)))
  expect_true(!is_alignment(42))
  expect_true(!is_alignment(3.14))
  expect_true(!is_alignment("Hello"))
})


