context("is_phylogeny")

test_that("Works", {
  expect_that(is_phylogeny(rcoal(n = 5)))
  expect_that(!is_phylogeny(rmtree(N = 2, n = 10)))
  expect_that(!is_phylogeny(42))
  expect_that(!is_phylogeny(3.14))
  expect_that(!is_phylogeny("Hello"))
})
