context("normalized_rooted_branch_score")

test_that("The normalized rooted branch score is calculated correctly", {
  expect_equal(normalized_rooted_branch_score(c(1), c(1)), 0)
  expect_equal(normalized_rooted_branch_score(
    c(0.3, 0.4, 0.4), c(0.5, 0.2, 0.2)), 0.12)
})

test_that("It also works when not all branches are present",{
  expect_equal(normalized_rooted_branch_score(
      c(0.5, 0.2, NA), c(0.3, 0.4, 0.4)), 0.24)
  expect_equal(normalized_rooted_branch_score(
    c(0.5, Na, 0.2), c(0.3, NA, 0.4)), 0.08)
  })

test_that("The NRBS errors work", {
  expect_error(normalized_rooted_branch_score(c(1, 0.5), c(0)),
               "Vectors should be of equal length. If some branches are there in one
         tree but not in the other, the value for that missing branch should be NA")
  expect_error(normalized_rooted_branch_score(c(2), c(3)),
               "Branch lengths should be 1 or smaller.")
  expect_error(normalized_rooted_branch_score(c(0.6, 0.5, 3), c(1, 0.7, 1)),
               "Branch lengths should be 1 or smaller.")
})
