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

  # ERG
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$erg <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: ERG invalid"
  )

  # ERI
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$eri <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: ERI invalid"
  )


  # SCR
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$scr <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: SCR invalid"
  )

  # SIRG
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$sirg <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: SIRG invalid"
  )

  # SIRI
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$siri <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: SIRI invalid"
  )

  # add_outgroup
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$add_ougroup <- "present"
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: add_ougroup must be absent"
  )

  # age
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$age[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: age invalid"
  )

  # mutation rate
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$mutation_rate[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: mutation_rate invalid"
  )
  # n_alignments
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$n_alignments[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: n_alignments invalid"
  )

  # sequence_length
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$sequence_length[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: sequence_length invalid"
  )

  # n_beast_runs
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$n_beast_runs[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: n_beast_runs invalid"
  )

  # mcmc_chainlength
  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$mcmc_chainlength[2] <- -123.456
  expect_message(
    file_has_valid_parameters(file = file, verbose = TRUE),
    "file_has_valid_parameters: mcmc_chainlength invalid"
  )

})
