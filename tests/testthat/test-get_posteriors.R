context("get_posteriors")

test_that("get_posteriors: toy examples 1", {

  filename <- find_path("toy_example_1.RDa")
  file <- read_file(filename)
  posteriors <- get_posteriors(file)

  expect_equal(length(posteriors), 2)
  expect_true(RBeast::is_posterior(posteriors[[1]][[1]]))

})

test_that("get_posteriors: toy examples 3", {

  filename <- find_path("toy_example_3.RDa")
  file <- read_file(filename)
  posteriors <- get_posteriors(file)

  expect_equal(length(posteriors), 8)
  expect_true(RBeast::is_posterior(posteriors[[8]][[1]]))

})


test_that("get_posteriors: add one", {

  filename <- "test-get_posteriors.RDa"

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
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  add_posteriors(filename = filename)
  file <- read_file(filename)
  posteriors <- get_posteriors(file)
  expect_equal(length(posteriors), 2)


  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))
})

test_that("get_posteriors: add two", {

  filename <- "test-get_posteriors.RDa"
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
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = n_posteriors,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  add_posteriors(filename = filename)

  posteriors <- get_posteriors(read_file(filename))
  expect_equal(length(posteriors), n_posteriors * 2)


  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))
})
