context("collect_parameters")

test_that("collect_parameters: is add_outgroup really gone?", {
  # Testing
  filenames <- create_test_parameter_files()
  for (filename in filenames) {
    file <- read_file(filename)
    expect_equal("rng_seed" %in% names(file$parameters[2, , 2]), TRUE)
    expect_equal("add_outgroup" %in% names(file$parameters[2, , 2]), FALSE)
  }
})
