context("calc_nltt_stats_from_files")

test_that("calc_nltt_stats_from_files use", {
  nltt_stats <- calc_nltt_stats_from_files(
    filenames = c(
      find_path("toy_example_1.RDa"),
      find_path("toy_example_2.RDa")
    )
  )
  expected_names <- c("filename", "sti", "ai", "pi", "si", "nltt_stat")
  expect_identical(names(nltt_stats), expected_names)
})
