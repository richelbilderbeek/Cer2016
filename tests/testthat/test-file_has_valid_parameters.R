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
    "verbose should be TRUE or FALSE"
  )

  # ERG
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$erg <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "ERG invalid"
  )

  # ERI
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$eri <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "ERI invalid"
  )


  # SCR
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$scr <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "SCR invalid"
  )

  # SIRG
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$sirg <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "SIRG invalid"
  )

  # SIRI
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$siri <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "SIRI invalid"
  )

  # add_outgroup
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$add_ougroup <- "present"
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "add_ougroup must be absent"
  )

  # age
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$age[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "age invalid"
  )

  # mutation rate
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$mutation_rate[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "mutation_rate invalid"
  )
  # n_alignments
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$n_alignments[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "n_alignments invalid"
  )

  # sequence_length
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$sequence_length[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "sequence_length invalid"
  )

  # n_beast_runs
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$n_beast_runs[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "n_beast_runs invalid"
  )

  # nspp
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$nspp[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "nspp invalid"
  )

})
