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

test_that("collect_parameters: fixing #52", {

  # Testing
  file <- read_file("/home/p230198/Peregrine2017/article_0_0_0_0_0.RDa") #nolint
  expect_equal("rng_seed" %in% names(file$parameters[2, , 2]), TRUE)
  expect_equal("add_outgroup" %in% names(file$parameters[2, , 2]), FALSE)

  folder <- "/home/p230198/Peregrine" #nolint
  all_parameter_filenames <- paste(
    folder,
    list.files(folder, pattern = "\\.RDa"), sep = "/"
  )
  expect_silent(
    collect_parameters(all_parameter_filenames, verbose = TRUE)
  )

})
