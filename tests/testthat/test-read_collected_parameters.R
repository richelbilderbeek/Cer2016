context("read_collected_parameters")

test_that("read_collected_parameters works", {
  df <- read_collected_parameters()
  expect_true(class(df) == "data.frame")
})
