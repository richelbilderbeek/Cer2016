context("branch_sorter")

test_that("branches are sorted correctly", {
  phylogeny   <- ape::read.tree("branch_sorter_testfile.txt")
  df          <- branch_sorter(phylogeny)
  expect_equivalent(length(names(df$ordered.branches)), 2)

  # expect_equal(count(names(df),"branch_length"), 1)
  #expect_equal(count(names(df),"taxon_name"), 1)
  #expect_equal(count(names(df),"brach_length"), 1)

  expect_equal(nrow(df$ordered.branches), 3)
  # expect_equal(length(df$taxon_name), 3)
  # expect_equal(length(df$branch_length), 3)
  # expected <- df(taxon_name = c("A", "B", "C"), branch_length = c(1,1,2))
  # expect_equal(df, expected)
})
