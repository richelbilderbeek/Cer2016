context("read_collected_nltt_stats")

test_that("read_collected_nltt_stats: use", {
  df <- read_collected_nltt_stats()
  expected_names <- c("filename", "sti", "ai", "pi", "si", "nltt_stat")
  expect_equal(names(df), expected_names)
})
