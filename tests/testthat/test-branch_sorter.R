context("branch_sorter")


test_that("multiplication works", {
  phylogeny <-
  df <- branch_sorter(phylogeny)
  expect_equal(length(names(df)), 2)

  #expect_equal(count(names(df),"brach_length"), 1)
  #expect_equal(count(names(df),"taxon_name"), 1)
  #expect_equal(count(names(df),"brach_length"), 1)
  expect_equal(nrow(df), 3)
  expect_equal(length(df$taxon_name), 3)
  expect_equal(length(df$branch_length), 3)
  expected <- df(taxon_name = c("A", "B", "C"), branch_length = c(1,1,2))
  expect_equal(df, expected)
})
