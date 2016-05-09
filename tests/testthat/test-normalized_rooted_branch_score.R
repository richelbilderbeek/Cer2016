context("normalized_rooted_branch_score")

test_that("the normalized rooted branch score is calculated correctly", {
  expect_equal(normalized_rooted_branch_score(c(1), c(1)), 0)
  expect_equal(normalized_rooted_branch_score(
    c(0.3, 0.4, 0.4), c(0.5, 0.2, 0.2)), 0.12)
  expect_equal(normalized_rooted_branch_score(
    c(0.5, 0.2), c(0.3, 0.4, 0.4)), 0.24)
  })

test_that("the NRBS errors work", {
  expect_error(normalized_rooted_branch_score(c(2), c(3)),
               "Branch lengths should be 1 or smaller.")
  expect_error(normalized_rooted_branch_score(c(0.6, 0.5, 3), c(1, 0.7, 1)),
               "Branch lengths should be 1 or smaller.")
})

