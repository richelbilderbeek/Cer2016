context("read_collected_times")

test_that("read_collected_times: use", {
  df <- read_collected_times()
  expect_true(identical(names(df), c("per_file", "full_process")))
})
