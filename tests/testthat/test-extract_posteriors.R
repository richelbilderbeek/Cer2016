context("extract_posteriors")

test_that("extract_posteriors: add one", {

  filename <- "test-extract_posteriors.RDa"
  n_posteriors <- 1

  # Pre clean
  if (file.exists(filename)) {
    file.remove(filename)
  }

  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    n_species_trees_samples = 1,
    add_outgroup = TRUE,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = n_posteriors,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  add_posteriors(filename = filename)
  file <- read_file(filename)
  posteriors <- extract_posteriors(file)
  expect_equal(length(posteriors), n_posteriors)


  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_equal(file.exists(filename), FALSE)
})

test_that("extract_posteriors: add two", {

  filename <- "test-extract_posteriors.RDa"
  n_posteriors <- 2

  # Pre clean
  if (file.exists(filename)) {
    file.remove(filename)
  }

  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    n_species_trees_samples = 1,
    add_outgroup = TRUE,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = n_posteriors,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  add_posteriors(filename = filename)

  posteriors <- extract_posteriors(read_file(filename))
  expect_equal(length(posteriors), n_posteriors)


  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_equal(file.exists(filename), FALSE)
})
