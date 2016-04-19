context("is_phylogeny")

test_that("Works", {
  expect_equal(
    is_phylogeny(ape::rcoal(n = 5)),
    TRUE
  )
  expect_equal(
    is_phylogeny(ape::rmtree(N = 2, n = 10)),
    FALSE
  )
  expect_equal(
    is_phylogeny(42),
    FALSE
  )
  expect_equal(
    is_phylogeny(3.14),
    FALSE
  )
  expect_equal(
    is_phylogeny("Hello"),
    FALSE
  )
})
