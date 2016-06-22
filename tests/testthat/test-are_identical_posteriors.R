context("are_identical_posteriors")

test_that("are_identical_posteriors: use from file", {
  filename <- find_path("toy_example_4.RDa")
  file <- read_file(filename)
  posterior_1 <- get_posterior_by_index(file, 1)
  posterior_2 <- get_posterior_by_index(file, 2)
  posterior_3 <- get_posterior_by_index(file, 3)
  posterior_4 <- get_posterior_by_index(file, 4)
  expect_true(is_beast_posterior(posterior_1))
  expect_true(is_beast_posterior(posterior_2))
  expect_true(is_beast_posterior(posterior_3))
  expect_true(is_beast_posterior(posterior_4))

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

})


test_that("are_identical_posteriors: use from local simulation", {

  base_filename <- "are_identical_posteriors"
  beast_log_filename <- paste0(base_filename, ".log")
  beast_trees_filename <- paste0(base_filename, ".trees")
  beast_state_filename <- paste0(base_filename, ".xml.state")

  # Pre cleaning up
  if (file.exists(beast_log_filename)) {
    file.remove(beast_log_filename)
  }
  if (file.exists(beast_trees_filename)) {
    file.remove(beast_trees_filename)
  }
  if (file.exists(beast_state_filename)) {
    file.remove(beast_state_filename)
  }

  alignment <- convert_phylogeny_to_alignment(
    phylogeny = ape::rcoal(5),
    sequence_length = 10,
    mutation_rate = 1
  )
  beast_jar_path <- find_beast_jar_path()
  testit::assert(file.exists(beast_jar_path))

  posterior_1 <- alignment_to_beast_posterior(
    alignment_dnabin = alignment,
    mcmc_chainlength = 10000,
    base_filename = base_filename,
    rng_seed = 42,
    beast_jar_path = beast_jar_path,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  posterior_2 <- alignment_to_beast_posterior(
    alignment_dnabin = alignment,
    mcmc_chainlength = 10000,
    base_filename = base_filename,
    rng_seed = 42,
    beast_jar_path = beast_jar_path,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  posterior_3 <- alignment_to_beast_posterior(
    alignment_dnabin = alignment,
    mcmc_chainlength = 10000,
    base_filename = base_filename,
    rng_seed = 314,
    beast_jar_path = beast_jar_path,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )

  expect_true(is_beast_posterior(posterior_1))
  expect_true(is_beast_posterior(posterior_2))
  expect_true(is_beast_posterior(posterior_3))
  expect_true(are_identical_posteriors(posterior_1, posterior_1))
  expect_true(are_identical_posteriors(posterior_1, posterior_2))
  expect_true(are_identical_posteriors(posterior_2, posterior_2))
  expect_true(are_identical_posteriors(posterior_3, posterior_3))
  expect_false(are_identical_posteriors(posterior_1, posterior_3))
  expect_false(are_identical_posteriors(posterior_2, posterior_3))
})
