context("collect_files_esses")

test_that("collect_files_esses: use", {
  filenames <- find_paths(c("toy_example_3.RDa", "toy_example_4.RDa"))
  df <- collect_files_esses(filenames)
  expect_equal(nrow(df), 16)
})
