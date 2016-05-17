context("branch_sorter")

test_that("branches are sorted correctly", {
  phylogeny   <- "branch_sorter_testfile.txt"
  df          <- branch_sorter(phylogeny)
  expect_equivalent(length(names(df$ordered.branches)), 2)

  expect_equal(length(grep("branch_length", names(df))), 1)
  expect_equal(length(grep("taxon_name", names(df))), 1)

  expect_equal(nrow(df$ordered.branches), 3)
  expect_equal(length(df$taxon_name), 3)
  expect_equal(length(df$branch_length), 3)
  expected <- c(c("A", "B", "C"), c(1, 1, 2))
  expect_equal(c(df$taxon_name, df$branch_length),  expected)
})

test_that("...even if they are of different lengths!", {
  phylogeny   <- "branch_sorter_testfile2.txt"
  df          <- branch_sorter(phylogeny)
  expect_equivalent(length(names(df$ordered.branches)), 2)

  expect_equal(length(grep("branch_length", names(df))), 1)
  expect_equal(length(grep("taxon_name", names(df))), 1)

  expect_equal(nrow(df$ordered.branches), 3)
  expect_equal(length(df$taxon_name), 3)
  expect_equal(length(df$branch_length), 3)
  expected <- c(c("A", "B", "C"), c(2, 1, 1))
  expect_equal(c(df$taxon_name, df$branch_length),  expected)
})

test_that("...even if they are in a different order!", {
  phylogeny    <- "branch_sorter_testfile3.txt"
  df           <- branch_sorter(phylogeny)
  expect_equivalent(length(names(df$ordered.branches)), 2)

  expect_equal(length(grep("branch_length", names(df))), 1)
  expect_equal(length(grep("taxon_name", names(df))), 1)

  expect_equal(nrow(df$ordered.branches), 3)
  expect_equal(length(df$taxon_name), 3)
  expect_equal(length(df$branch_length), 3)
  expected <- c(c("A", "B", "C"), c(1, 2, 1))
  expect_equal(c(df$taxon_name, df$branch_length),  expected)
})
