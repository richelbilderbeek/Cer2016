context("get_posterior")

test_that("get_posterior: #1", {
  file <- read_file(find_path("toy_example_1.RDa"))
  posterior_1 <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  posterior_2 <- get_posterior(file = file, sti = 2, ai = 1, pi = 1)
  expect_true(RBeast::is_posterior(posterior_1))
  expect_true(RBeast::is_posterior(posterior_2))
})

test_that("get_posterior: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  posterior_1 <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  posterior_2 <- get_posterior(file = file, sti = 1, ai = 1, pi = 2)
  posterior_3 <- get_posterior(file = file, sti = 1, ai = 2, pi = 1)
  posterior_4 <- get_posterior(file = file, sti = 1, ai = 2, pi = 2)
  posterior_5 <- get_posterior(file = file, sti = 2, ai = 1, pi = 1)
  posterior_6 <- get_posterior(file = file, sti = 2, ai = 1, pi = 2)
  posterior_7 <- get_posterior(file = file, sti = 2, ai = 2, pi = 1)
  posterior_8 <- get_posterior(file = file, sti = 2, ai = 2, pi = 2)
  expect_true(RBeast::is_posterior(posterior_1))
  expect_true(RBeast::is_posterior(posterior_2))
  expect_true(RBeast::is_posterior(posterior_3))
  expect_true(RBeast::is_posterior(posterior_4))
  expect_true(RBeast::is_posterior(posterior_5))
  expect_true(RBeast::is_posterior(posterior_6))
  expect_true(RBeast::is_posterior(posterior_7))
  expect_true(RBeast::is_posterior(posterior_8))
})

test_that("set_posterior: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  # Only use first four out of eight
  posterior_1 <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  posterior_2 <- get_posterior(file = file, sti = 1, ai = 1, pi = 2)
  posterior_3 <- get_posterior(file = file, sti = 1, ai = 2, pi = 1)
  posterior_4 <- get_posterior(file = file, sti = 1, ai = 2, pi = 2)

  # All same posteriors are identical
  expect_true(are_identical_posteriors(posterior_1, posterior_1))
  expect_true(are_identical_posteriors(posterior_2, posterior_2))
  expect_true(are_identical_posteriors(posterior_3, posterior_3))
  expect_true(are_identical_posteriors(posterior_4, posterior_4))

  # All different posteriors are different
  expect_false(are_identical_posteriors(posterior_1, posterior_2))
  expect_false(are_identical_posteriors(posterior_1, posterior_3))
  expect_false(are_identical_posteriors(posterior_1, posterior_4))
  expect_false(are_identical_posteriors(posterior_2, posterior_3))
  expect_false(are_identical_posteriors(posterior_2, posterior_4))
  expect_false(are_identical_posteriors(posterior_3, posterior_4))

  # Copy #1 over #2
  file <- set_posterior(file, sti = 1, ai = 1, pi = 2, posterior_1)
  expect_true(
    are_identical_posteriors(
      get_posterior(file, sti = 1, ai = 1, pi = 1),
      get_posterior(file, sti = 1, ai = 1, pi = 2)
    )
  )

  # Copy #3 over #4
  file <- set_posterior(file, sti = 1, ai = 2, pi = 2, posterior_3)
  expect_true(
    are_identical_posteriors(
      get_posterior(file, sti = 1, ai = 2, pi = 1),
      get_posterior(file, sti = 1, ai = 2, pi = 2)
    )
  )
})

test_that("get_posterior from fresh file", {
  filename <- "test-extract_posterior.RDa"

  napst <- 3 # Number of alignments per species tree
  nppa <- 4 # Number of posteriors per alignment

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
    n_alignments = napst,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = nppa,
    filename = filename
  )

  file <- read_file(filename = filename)

  # No posterior yet
  expect_error(
    get_posterior(file, sti = 2, ai = napst, pi = nppa),
    "posterior absent at index 24"
  )

  # Getting a posterior
  posterior <- RBeast::parse_beast_posterior(
    trees_filename = find_path(filename = "beast2_example_output.trees"),
    log_filename   = find_path(filename = "beast2_example_output.log")
  )
  expect_true(RBeast::is_posterior(posterior))

  file <- set_posterior(
    file = file, sti = 2, ai = napst, pi = nppa,
    posterior = posterior
  )

  posterior_again <- get_posterior(
    file = file,
    sti = 2, ai = napst, pi = nppa
  )

  expect_true(
    are_identical_posteriors(
      posterior, posterior_again
    )
  )

  file.remove(filename)
})

test_that("get_posterior: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))

  expect_error(
    get_posterior(file = file, sti = -314, ai = 1, pi = 1),
    "sti must be at least 1"
  )

  expect_error(
    get_posterior(file = file, sti = 314, ai = 1, pi = 1),
    "sti must at most be 2"
  )

  expect_error(
    get_posterior(file = file, sti = 1, ai = -314, pi = 1),
    "ai must be at least 1"
  )

  expect_error(
    get_posterior(file = file, sti = 1, ai = 314, pi = 1),
    "ai must at most be napst"
  )

  expect_error(
    get_posterior(file = file, sti = 1, ai = 1, pi = -314),
    "pi must be at least 1"
  )

  expect_error(
    get_posterior(file = file, sti = 1, ai = 1, pi = 314),
    "pi must at most be nppa"
  )

})
