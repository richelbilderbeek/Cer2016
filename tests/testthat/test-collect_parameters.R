context("collect_parameters")

test_that("collect_parameters: is add_outgroup really gone?", {
  # Testing
  filenames <- paste0("collect_parameters_", seq(1, 4), ".RDa")
  create_test_parameter_files(filenames = filenames)
  for (filename in filenames) {
    file <- read_file(filename)
    expect_true("rng_seed" %in% names(file$parameters[2, , 2]))
    expect_false("add_outgroup" %in% names(file$parameters[2, , 2]))
  }
  file.remove(filenames)
})


test_that("collect_parameters: invalid filenames return an empty data.frame", {

  df <- collect_parameters(filenames = c("inva.lid"))
  expect_equal(class(df), "data.frame")
  expect_equal(df$message, "No valid files supplied")
})



test_that("collect_parameters: abuse", {

  # verbose
  expect_error(
    collect_parameters(filenames = c(), verbose = "TRUE nor FALSE"),
    "collect_parameters: verbose should be TRUE or FALSE"
  )


  # Create a 'corrupt file'
  filename <- "test-collect_parameters.RDa"
  cat("I am not a valid file\n", file = filename)

  df <- collect_parameters(
    filenames = c(
      filename,
      find_path("toy_example_1.RDa")
    )
  )
  # One row per file
  expect_equal(nrow(df), 2)

  # File one has only NAs
  expect_true(is.na(df[1, "rng_seed"]))

  # File two (a toy example) is valid
  expect_false(is.na(df[2, "rng_seed"]))
  file.remove(filename)
})
