context("create_test_parameter_files")

test_that("create_test_parameter_files: use", {
  filenames <- paste0("create_test_parameter_files_", seq(1, 4), ".RDa")

  expect_silent(
    create_test_parameter_files(filenames = filenames)
  )

  expect_equal(file.exists(filenames), rep(TRUE, 4))
  file.remove(filenames)
})

test_that("create_test_parameter_files: abuse", {

  expect_error(
    create_test_parameter_files(
      filenames = c("only", "two")
    ),
    "create_test_parameter_files: must have exactly four filenames"
  )

})
