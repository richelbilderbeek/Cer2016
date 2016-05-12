context("collect_parameters")

test_that("collect_parameters of parameter files in package", {
  parameter_filename_a <- find_path("article_0_0_0_0_0.RDa")
  parameter_filename_b <- find_path("article_0_1_4_0_2.RDa")
  parameter_filename_c <- find_path("toy_example_1.RDa")
  testit::assert(file.exists(parameter_filename_a))
  testit::assert(file.exists(parameter_filename_b))
  testit::assert(file.exists(parameter_filename_c))
  all_parameter_filenames <- c(
    parameter_filename_a,
    parameter_filename_b,
    parameter_filename_c
  )
  df <- collect_parameters(all_parameter_filenames)
  expect_equal(nrow(df), 3)
})

test_that("collect_parameters of parameter files in any folder", {
  pcname <- system('uname -n', intern = TRUE)
  folder <- NULL
  if (pcname == "fwn-biol-132-102") folder <- "/home/p230198/Peregrine"
  if (pcname == "druten") folder <- "/home/richel/Peregrine"
  if (is.null(folder)) {
    skip("Don't know where others store their data set")
  }
  parameter_filenames <- paste(
    folder,
    c(
      "article_1_2_4_1_1.RDa",
      "article_2_2_4_1_1.RDa",
      "article_3_2_4_1_1.RDa"
    ), sep = "/")
  testit::assert(file.exists(parameter_filenames) == rep(TRUE, 3))
  df <- collect_parameters(parameter_filenames)
  expect_equal(nrow(df), 3)
})
