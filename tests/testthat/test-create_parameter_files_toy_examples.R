context("create_test_parameter_files")

test_that("create_test_parameter_files works", {
  expect_silent(
    create_test_parameter_files()
  )

  filenames <- create_test_parameter_files()
  expect_equal(file.exists(filenames), rep(TRUE, 4))
})
