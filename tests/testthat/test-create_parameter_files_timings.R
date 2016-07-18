context("create_parameter_files_timings")

test_that("create_parameter_files_timings works", {
  filenames <- create_parameter_files_timings()

  #Local test
  if (1 == 2) {
    file <- read_file(filenames[1])
    message("rng_seed" %in% names(file$parameters[2, , 2]))
    message("add_outgroup" %in% names(file$parameters[2, , 2]))
    message("version" %in% names(file$parameters[2, , 2]))
  }

  for (filename in filenames) {
    expect_true(is_valid_file(filename))
    file <- read_file(filename)
    expect_true("rng_seed" %in% names(file$parameters[2, , 2]))
    expect_false("add_outgroup" %in% names(file$parameters[2, , 2]))
    file.remove(filename)
  }
})
