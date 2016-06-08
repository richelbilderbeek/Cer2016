context("is_valid_file")

test_that("is_valid_file works", {
  skip("First recreate toy examples")

  filename <- find_path("toy_example_1.RDa")
  expect_equal(file.exists(filename), TRUE)
  expect_equal(is_valid_file(filename), TRUE)
})
