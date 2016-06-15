context("is_valid_file")

test_that("is_valid_file: use", {
  filename <- find_path("toy_example_1.RDa")
  expect_equal(file.exists(filename), TRUE)
  expect_equal(is_valid_file(filename), TRUE)

  sink("/dev/null") # nolint
  expect_equal(is_valid_file(filename, verbose = TRUE), TRUE)
  sink()
})

test_that("is_valid_file: abuse", {
  expect_error(
    is_valid_file(filename = "inva.lid", verbose = "TRUE nor FALSE"),
    "is_valid_file: verbose should be TRUE or FALSE"
  )

  # Rest is a lot of work to check
})
