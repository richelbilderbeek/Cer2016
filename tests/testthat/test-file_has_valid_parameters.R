context("file_has_valid_parameters")


test_that("file_has_valid_parameters: use", {
  expect_true(
    file_has_valid_parameters(
      read_file(
        find_path("toy_example_1.RDa")
      )
    )
  )
})

test_that("file_has_valid_parameters: abuse", {

  expect_error(
    file_has_valid_parameters(
      file = read_file(find_path("toy_example_1.RDa")),
      verbose = "TRUE nor FALSE"
    ),
    "file_has_valid_parameters: verbose should be TRUE or FALSE"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$erg <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: ERG invalid"
  )

})
