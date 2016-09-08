context("collect_file_esses")

test_that("use", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_file_esses(filename)
  expect_equal(nrow(df), 8)
})
