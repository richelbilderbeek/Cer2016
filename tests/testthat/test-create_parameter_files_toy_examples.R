context("create_test_parameter_files")

test_that("create_test_parameter_files works", {
  expect_silent(
    create_test_parameter_files()
  )

  filenames <- paste0("create_test_parameter_files_", seq(1, 4), ".RDa")
  create_test_parameter_files(filenames = filenames)
  expect_equal(file.exists(filenames), rep(TRUE, 4))
  file.remove(filenames)
})
