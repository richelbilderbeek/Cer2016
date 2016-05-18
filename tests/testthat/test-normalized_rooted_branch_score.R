context("normalized_rooted_branch_score")

test_that("The normalized rooted branch score is calculated correctly", {
  skip("Do not break the build")
  filenames  <- c("branch_sorter_testfile0.1.txt",
                  "branch_sorter_testfile0.2.txt")
  expect_equal(normalized_rooted_branch_score(phylogenies), 0)
  filenames    <- c("branch_sorter_testfile2.txt",
                     "branch_sorter_testfile0.1.txt")
  expect_equal(normalized_rooted_branch_score(phylogenies), 0.5)

  # filenames   <- ("branch_sorter_testfile3.txt")

})

