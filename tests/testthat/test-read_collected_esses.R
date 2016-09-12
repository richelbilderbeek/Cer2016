context("read_collected_esses")

test_that("read_collected_esses use", {
  df <- read_collected_esses()
  expected_names <- c("filename", "sti", "ai", "pi", "min_ess")
  expect_equal(all(names(df) == expected_names))
  expect_true(is.factor(df$filename))
  expect_true(is.factor(df$sti))
  expect_true(is.factor(df$ai))
  expect_true(is.factor(df$pi))
})
