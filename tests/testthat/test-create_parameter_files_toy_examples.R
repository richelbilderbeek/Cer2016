context("create_parameter_files_toy_examples")

test_that("create_parameter_files_toy_examples works", {
  expect_silent(
    create_parameter_files_toy_examples()
  )

  filenames <- create_parameter_files_toy_examples()
  expect_equal(file.exists(filenames), rep(TRUE, 4))
})
