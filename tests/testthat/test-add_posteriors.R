context("add_posteriors")

test_that("two posteriors are added", {
  filename <- "test-add_posteriors_1.RDa"
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))
  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = 1,
    filename = filename
  )
  add_pbd_output(filename = filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)

  expect_error(
    get_posterior(
      file = read_file(filename),
      sti = 1, ai = 1, pi = 1
    ),
    "get_posterior: get_posterior_by_index: posterior absent at index 1"
  )

  n_posteriors_added <- add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )

  expect_equal(n_posteriors_added, 2)

  posterior_1 <- get_posterior_by_index(
    file = read_file(filename),
    i = 1
  )
  posterior_2 <- get_posterior_by_index(
    file = read_file(filename),
    i = 2
  )
  expect_true(is_posterior(posterior_1))
  expect_true(is_posterior(posterior_2))

  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))
})


test_that("four posteriors are added", {

  filename <- "test-add_posteriors_2.RDa"
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))

  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = 2,
    filename = filename
  )
  add_pbd_output(filename = filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)

  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 1
    ),
    "get_posterior_by_index: posterior absent at index 1"
  )
  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 2
    ),
    "get_posterior_by_index: posterior absent at index 2"
  )

  n_posteriors_added <- add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  expect_equal(n_posteriors_added, 4)

  posterior_1 <- get_posterior_by_index(
    file = read_file(filename),
    i = 1
  )
  posterior_2 <- get_posterior_by_index(
    file = read_file(filename),
    i = 2
  )
  posterior_3 <- get_posterior_by_index(
    file = read_file(filename),
    i = 3
  )
  posterior_4 <- get_posterior_by_index(
    file = read_file(filename),
    i = 4
  )
  expect_true(is_posterior(posterior_1))
  expect_true(is_posterior(posterior_2))
  expect_true(is_posterior(posterior_3))
  expect_true(is_posterior(posterior_4))

  file.remove(filename)

  expect_false(file.exists(filename))

})

test_that("three posteriors are added, middle is deleted and added again", {

  filename <- "test-add_posteriors_3.RDa"
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))

  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = 3,
    filename = filename
  )
  add_pbd_output(filename = filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)

  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 1
    ),
    "get_posterior_by_index: posterior absent at index 1"
  )
  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 2
    ),
    "get_posterior_by_index: posterior absent at index 2"
  )
  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 3
    ),
    "get_posterior_by_index: posterior absent at index 3"
  )

  # Only be verbose on Travis
  n_posteriors_added <- add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )

  expect_equal(n_posteriors_added, 6)

  posterior_1 <- get_posterior_by_index(
    file = read_file(filename),
    i = 1
  )
  posterior_2 <- get_posterior_by_index(
    file = read_file(filename),
    i = 2
  )
  posterior_3 <- get_posterior_by_index(
    file = read_file(filename),
    i = 3
  )

  expect_true(is_posterior(posterior_1))
  expect_true(is_posterior(posterior_2))
  expect_true(is_posterior(posterior_3))

  # Delete middle
  file <- read_file(filename)
  file <- set_posterior_by_index(
    file = file,
    i = 2,
    posterior = NA
  )
  saveRDS(file, file = filename)

  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 1
    )
  )
  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 2
    ),
    "get_posterior_by_index: posterior absent at index 2"
  )
  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 3
    )
  )

  # Add middle again
  n_posteriors_added <- add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = (regexpr("travis", getwd())[1] > 0)
  )

  expect_equal(n_posteriors_added, 1)
  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 1
    )
  )
  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 2
    )
  )
  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 3
    )
  )

  # Clean up
  expect_true(file.exists(filename))
  file.remove(filename)
  expect_false(file.exists(filename))
})


test_that("add_posteriors: abuse", {
  expect_error(
    add_posteriors(filename = "inva.lid", verbose = "TRUE not FALSE"),
    "add_posteriors: verbose should be TRUE or FALSE"
  )
  expect_error(
    add_posteriors(
      filename = "inva.lid",
      skip_if_output_present = "TRUE not FALSE"
    ),
    "add_posteriors: skip_if_output_present should be TRUE or FALSE"
  )
  expect_error(
    add_posteriors(filename = "inva.lid"),
    "add_posteriors: invalid filename"
  )
})
