# context("normalized_rooted_branch_score") #nolint

# test_that("The normalized rooted branch score is calculated correctly", { #nolint
#   expect_equal(normalized_rooted_branch_score(c(1), c(1)), 0) #nolint
#   expect_equal(normalized_rooted_branch_score( #nolint
#     c(0.3, 0.4, 0.4), c(0.5, 0.2, 0.2)), 0.12) #nolint
# }) #nolint
#
# test_that("It also works when not all branches are present", { #nolint
#   expect_equal(normalized_rooted_branch_score( #nolint
#       c(0.5, 0.2, NA), c(0.3, 0.4, 0.4)), 0.24) #nolint
#   expect_equal(normalized_rooted_branch_score( #nolint
#     c(0.5, NA, 0.2), c(0.3, NA, 0.4)), 0.08) #nolint
#   }) #nolint
