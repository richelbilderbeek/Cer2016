context("collect_files_n_posteriors")

test_that("collect_files_n_posteriors: basic use", {
  filenames <- c(
    find_path("toy_example_1.RDa"),
    find_path("toy_example_3.RDa")
  )
  df <- collect_files_n_posteriors(filenames, verbose = FALSE)
  expect_equal(names(df), c("filenames", "n_posteriors"))
  expect_equal(nrow(df), length(filenames))
  expect_equal(df$n_posteriors, c(1, 8))
})
