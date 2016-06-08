context("create_parameter_files_article")

test_that("create_parameter_files_article works", {
  filenames <- create_parameter_files_article()

  #Local test
  if (1 == 2) {
    file <- read_file(filenames[1])
    print("rng_seed" %in% names(file$parameters[2, , 2]))
    print("add_outgroup" %in% names(file$parameters[2, , 2]))
    print("version" %in% names(file$parameters[2, , 2]))
  }

  for (filename in filenames) {
    expect_equal(is_valid_file(filename), TRUE)
    file <- read_file(filename)
    expect_equal("rng_seed" %in% names(file$parameters[2, , 2]), TRUE)
    expect_equal("add_outgroup" %in% names(file$parameters[2, , 2]), FALSE)
    file.remove(filename)
  }
})
