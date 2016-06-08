context("add_alignment")

test_that("alignment is added", {
  filename <- "test-add_alignment.RDa"
  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    n_species_trees_samples = 1,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = 1,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(
    filename = filename,
    verbose = FALSE
  )
  expect_equal(
    is.na(read_file(filename = filename)$alignments),
    TRUE
  )
  add_alignments(
    filename = filename,
    verbose = FALSE
  )
  file <- read_file(filename = filename)
  expect_equal(class(file$alignments[[1]]) == "list", TRUE)
  expect_equal(class(file$alignments[[1]][[1]]) == "DNAbin", TRUE)

  # Cleaning up
  file.remove(filename)
  expect_equal(file.exists(filename), FALSE)
})


test_that("add_alignment: abuse", {

  expect_error(
    add_alignments(
      filename = find_path("toy_example_1.RDa"),
      verbose = "not TRUE nor FALSE"
    ),
    "add_alignments: verbose should be TRUE or FALSE"
  )
  expect_error(
    add_alignments(
      filename = "inva.lid",
      verbose = FALSE
    ),
    "add_alignments: invalid file"
  )
})
