context("collect_parameters")

test_that("collect_parameters: fixing #52", {
  # Testing
  #file <- read_file("/home/p230198/Peregrine/article_0_0_0_0_0.RDa")
  #parameter_values <- as.numeric(file$parameters[2, , 2])

  folder <- "/home/p230198/Peregrine"
  all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
  expect_silent(
    collect_parameters(all_parameter_filenames, verbose = TRUE)
  )

})
