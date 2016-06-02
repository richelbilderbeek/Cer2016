context("create_parameter_files_article")

test_that("create_parameter_files_article works", {
  filenames <- create_parameter_files_article()
  for (filename in filenames) {
    expect_equal(is_valid_file(filename), TRUE)
  }
})
