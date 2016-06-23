context("has_beast2")

test_that("BEAST2 is installed", {
  expect_true(has_beast2())
})
