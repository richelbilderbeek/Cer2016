context("collect_parameters")

test_that("collect_parameters: is add_outgroup really gone?", {
  # Testing
  filenames <- create_test_parameter_files()
  for (filename in filenames) {
    file <- read_file(filename)
    expect_true("rng_seed" %in% names(file$parameters[2, , 2]))
    expect_false("add_outgroup" %in% names(file$parameters[2, , 2]))
  }
})

test_that("collect_parameters: abuse", {
  expect_error(
    collect_parameters(filenames = c(), verbose = "TRUE nor FALSE"),
    "collect_parameters: verbose should be TRUE or FALSE"
  )
})
