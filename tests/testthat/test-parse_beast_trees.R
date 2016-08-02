context("parse_beast_trees")

test_that("parse_beast_trees: use", {
  posterior <- parse_beast_trees(find_path("is_posterior.trees"))
  expect_true(is_posterior(posterior))
})
