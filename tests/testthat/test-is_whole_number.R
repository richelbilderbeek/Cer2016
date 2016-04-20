context("is_whole_number")

test_that("basic usage", {
  expect_equal(is_whole_number(42), TRUE)
  expect_equal(is_whole_number(42.01), FALSE)
  expect_equal(is_whole_number("Hello"), FALSE)
  expect_equal(is_whole_number(c(1, 2)), FALSE)
})
