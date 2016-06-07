context("create_parameter_files_toy_examples")

test_that("create_parameter_files_toy_examples works", {
  expect_silent(
    filenames <- create_parameter_files_toy_examples()
  )

  expect_equal(file.exists(filenames), TRUE)
})
