context("normalized_rooted_branch_score")

test_that("The normalized rooted branch score is calculated correctly", {
  filenames  <- c("branch_sorter_testfile0.1.txt",
                  "branch_sorter_testfile0.2.txt")
  expect_equal(normalized_rooted_branch_score(filenames), 0)

  # phylogeny   <- ape::read.tree("branch_sorter_testfile2.txt")

  # phylogeny   <- ape::read.tree("branch_sorter_testfile3.txt")

})

