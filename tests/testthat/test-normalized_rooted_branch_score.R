context("normalized_rooted_branch_score")

test_that("The normalized rooted branch score is calculated correctly", {
  expect_equal(normalized_rooted_branch_score(c(1), c(1)), 0)
  expect_equal(normalized_rooted_branch_score(
    c(0.3, 0.4, 0.4), c(0.5, 0.2, 0.2)), 0.12)
})

test_that("It also works when not all branches are present", {
  expect_equal(normalized_rooted_branch_score(
      c(0.5, 0.2, NA), c(0.3, 0.4, 0.4)), 0.24)
  expect_equal(normalized_rooted_branch_score(
    c(0.5, NA, 0.2), c(0.3, NA, 0.4)), 0.08)
  })

