context("calc_nltt_stats_from_files")

test_that("calc_nltt_stats_from_files: use", {
  nltt_stats <- calc_nltt_stats_from_files(
    filenames = c(
      find_path("toy_example_1.RDa"),
      find_path("toy_example_2.RDa")
    )
  )

  expected_names <- c("filename", "sti", "ai", "pi", "si", "nltt_stat")
  expect_identical(names(nltt_stats), expected_names)
})

test_that("calc_nltt_stats_from_files: fix #112", {
  filename <- find_path("toy_example_1.RDa")
  nltt_stats <- calc_nltt_stats_from_files(
    filenames = c(filename)
  )
  # Th tenth posterior always has an nLTT statistics of 0.0
  expect_true(sum(nltt_stats[ nltt_stats$si == 10, ]$nltt_stat) > 0)
})


test_that("calc_nltt_stats_from_files: abuse", {

  expect_error(
    calc_nltt_stats_from_files(filenames = c("inva.lid")),
    "invalid file "
  )

})
