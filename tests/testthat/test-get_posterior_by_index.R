context("get_posterior_by_index")

test_that("get_posterior_by_index: #1", {
  file <- read_file(find_path("toy_example_1.RDa"))
  i <- 1
  posterior <- get_posterior_by_index(file, i)
  expect_true(RBeast::is_posterior(posterior))
})

test_that("get_posterior_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  i <- 4
  posterior <- get_posterior_by_index(file, i)
  expect_true(RBeast::is_posterior(posterior))
  expect_true(
    are_identical_posteriors(
      posterior,
      get_posterior_by_index(file, i)
    )
  )
})

test_that("set_posterior_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  posterior_1 <- get_posterior_by_index(file, 1)
  posterior_2 <- get_posterior_by_index(file, 2)
  posterior_3 <- get_posterior_by_index(file, 3)
  posterior_4 <- get_posterior_by_index(file, 4)
  expect_true(RBeast::is_posterior(posterior_1))
  expect_true(RBeast::is_posterior(posterior_2))
  expect_true(RBeast::is_posterior(posterior_3))
  expect_true(RBeast::is_posterior(posterior_4))

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
  file <- set_posterior_by_index(file, 2, posterior_1)
  expect_true(
    are_identical_posteriors(
      get_posterior_by_index(file, 1),
      get_posterior_by_index(file, 2)
    )
  )

  # Copy #3 over #4
  file <- set_posterior_by_index(file, 4, posterior_3)
  expect_true(
    are_identical_posteriors(
      get_posterior_by_index(file, 3),
      get_posterior_by_index(file, 4)
    )
  )
})

test_that("get_posterior_by_index from fresh file", {
  filename <- "test-extract_posterior_by_index.RDa"
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

  file <- read_file(filename = filename)

  # No posterior yet
  expect_error(
    get_posterior_by_index(file, 1),
    "posterior absent at index 1"
  )
  expect_error(
    get_posterior_by_index(file, 2),
    "posterior absent at index 2"
  )

  # Getting a posterior
  posterior <- RBeast::parse_beast_posterior(
    trees_filename = find_path(filename = "beast2_example_output.trees"),
    log_filename   = find_path(filename = "beast2_example_output.log")
  )
  expect_true(RBeast::is_posterior(posterior))

  file <- set_posterior_by_index(
    file = file,
    i = 2,
    posterior = posterior
  )

  posterior_again <- get_posterior_by_index(
    file = file,
    i = 2
  )

  expect_true(
    are_identical_posteriors(
      posterior, posterior_again
    )
  )

  file.remove(filename)
})


test_that("get_posterior_by_index: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))

  expect_error(
    get_posterior_by_index(file = file, i = -314),
    "index must be at least 1"
  )

  expect_error(
    get_posterior_by_index(file = file, i = 42),
    "index must be less than number of posteriors"
  )

  file <- set_posterior_by_index(file = file, i = 1, posterior = NA)
  expect_error(
    get_posterior_by_index(file = file, i = 1),
    "posterior absent at index 1"
  )

})
