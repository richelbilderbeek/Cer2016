context("collect_posterior_filenames")

## TODO: Rename context
## TODO: Add more tests

test_that("collect_posterior_filenames for toy example 1", {
  parameter_filename <- find_path("toy_example_1.RDa")
  testit::assert(file.exists(parameter_filename))
  posterior_filenames <- collect_posterior_filenames(parameter_filename)
  expect_equal(length(posterior_filenames), 1)
  expected <- c(find_path("toy_example_1_1_1_1.trees"))
  expect_equal(posterior_filenames[1], expected[1])
})

test_that("collect_posterior_filenames for toy example 4", {
  parameter_filename <- find_path("toy_example_4.RDa")
  testit::assert(file.exists(parameter_filename))
  posterior_filenames <- collect_posterior_filenames(parameter_filename)
  expect_equal(length(posterior_filenames), 8)
  expected <- c(
   find_path("toy_example_4_1_1_1.trees"),
   find_path("toy_example_4_1_1_2.trees"),
   find_path("toy_example_4_1_2_1.trees"),
   find_path("toy_example_4_1_2_2.trees"),
   find_path("toy_example_4_2_1_1.trees"),
   find_path("toy_example_4_2_1_2.trees"),
   find_path("toy_example_4_2_2_1.trees"),
   find_path("toy_example_4_2_2_2.trees")
  )
  expected <- sort(expected)
  posterior_filenames <- sort(posterior_filenames)
  expect_equal(posterior_filenames, expected)
})
