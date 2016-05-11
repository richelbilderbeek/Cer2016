context("collect_posterior_filenames")

## TODO: Rename context
## TODO: Add more tests

test_that("collect_posterior_filenames for toy example 1", {
  parameter_filename <- find_path("toy_example_1.RDa")
  testit::assert(file.exists(parameter_filename))
  posterior_filenames <- collect_posterior_filenames(parameter_filename)
  expect_equal(length(posterior_filenames), 1)
  expected <- c("toy_example_1_1_1_1.RDa")
  expect_equal(posterior_filenames, expected)
})

test_that("collect_posterior_filenames for toy example 4", {
  parameter_filename2 <- find_path("toy_example_4.RDa")
  #parameter_filename2 <- read_file("toy_example_4.RDa")
  #parameter_filename2 <- load("toy_example_4.RDa")
  testit::assert(file.exists(parameter_filename2))
  posterior_filenames2 <- collect_posterior_filenames("toy_example_4.RDa")
  expect_equal(length(posterior_filenames2), 8)
  expected2 <- c("toy_example_4_1_1_1.trees",
                "toy_example_4_1_1_2.trees",
                "toy_example_4_1_2_1.trees",
                "toy_example_4_1_2_2.trees",
                "toy_example_4_2_1_1.trees",
                "toy_example_4_2_1_2.trees",
                "toy_example_4_2_2_1.trees",
                "toy_example_4_2_2_2.trees"
                )
  expect_equal(posterior_filenames2, expected2)
})
