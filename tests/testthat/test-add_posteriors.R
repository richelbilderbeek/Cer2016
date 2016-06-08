context("add_posteriors")

test_that("one posterior is added", {
  filename <- "test-add_posteriors_1.RDa"
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_equal(file.exists(filename), FALSE)

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
  add_alignments(
    filename = filename,
    verbose = FALSE
  )

  expect_equal(is.na(read_file(filename = filename)$posteriors[[1]]), TRUE)

  n_posteriors_added <- add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  expect_equal(is.na(read_file(filename = filename)$posteriors[[1]]), FALSE)
  expect_equal(n_posteriors_added, 1)

  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_equal(file.exists(filename), FALSE)
})


test_that("two posteriors are added", {

  filename <- "test-add_posteriors_2.RDa"
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_equal(file.exists(filename), FALSE)

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
    n_beast_runs = 2,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(
    filename = filename,
    verbose = FALSE
  )
  add_alignments(
    filename = filename,
    verbose = FALSE
  )

  expect_equal(is.na(read_file(filename = filename)$posteriors[[1]]), TRUE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[2]]), TRUE)

  n_posteriors_added <- add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  expect_equal(n_posteriors_added, 2)

  expect_equal(is.na(read_file(filename = filename)$posteriors[[1]]), FALSE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[2]]), FALSE)

  file.remove(filename)

  expect_equal(file.exists(filename), FALSE)

})

test_that("three posteriors are added, middle is deleted and added again", {

  filename <- "test-add_posteriors_3.RDa"
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_equal(file.exists(filename), FALSE)

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
    n_beast_runs = 3,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(
    filename = filename,
    verbose = FALSE
  )
  add_alignments(
    filename = filename,
    verbose = FALSE
  )

  expect_equal(is.na(read_file(filename = filename)$posteriors[[1]]), TRUE )
  expect_equal(is.na(read_file(filename = filename)$posteriors[[2]]), TRUE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[3]]), TRUE)

  n_posteriors_added <- add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  expect_equal(n_posteriors_added, 3)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[1]]), FALSE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[2]]), FALSE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[3]]), FALSE)

  # Delete middle
  file <- read_file(filename)
  file$posteriors[[2]][[1]] <- NA
  saveRDS(file, file = filename)

  expect_equal(is.na(read_file(filename = filename)$posteriors[[1]]), FALSE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[2]]), TRUE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[3]]), FALSE)

  # Add middle again
  n_posteriors_added <- add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  expect_equal(n_posteriors_added, 1)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[1]]), FALSE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[2]]), FALSE)
  expect_equal(is.na(read_file(filename = filename)$posteriors[[3]]), FALSE)

  # Clean up
  expect_equal(file.exists(filename), TRUE)
  file.remove(filename)
  expect_equal(file.exists(filename), FALSE)
})
