context("create_parameter_files_article")

test_that("create_parameter_files_article works", {
  filenames <- create_parameter_files_article()

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
    expect_true("nspp" %in% names(file$parameters[2, , 2]))
    expect_true("rng_seed" %in% names(file$parameters[2, , 2]))
    expect_false("add_outgroup" %in% names(file$parameters[2, , 2]))
    expect_equal(extract_nspp(file), 1000) # 1000 posterior trees
    file.remove(filename)
  }
})
