context("read_collected_n_taxa")

test_that("read_collected_n_taxa works", {
  df <- read_collected_n_taxa()
  expect_true(class(df) == "data.frame")
})
