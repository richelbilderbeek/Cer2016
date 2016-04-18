context("is_phylogeny")

test_that("Works", {
  expect_true(is_phylogeny(rcoal(n = 5)))
  expect_true(!is_phylogeny(rmtree(N = 2, n = 10)))
  expect_true(!is_phylogeny(42))
  expect_true(!is_phylogeny(3.14))
  expect_true(!is_phylogeny("Hello"))
})
