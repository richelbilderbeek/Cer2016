context("are_identical_trees_posteriors")

test_that("are_identical_trees_posteriors: use from file", {
  filename <- find_path("toy_example_4.RDa")
  file <- read_file(filename)
  posterior_1 <- get_posterior_by_index(file, 1)
  posterior_2 <- get_posterior_by_index(file, 2)
  posterior_3 <- get_posterior_by_index(file, 3)
  posterior_4 <- get_posterior_by_index(file, 4)
  expect_true(RBeast::is_trees_posterior(posterior_1$trees))
  expect_true(RBeast::is_trees_posterior(posterior_2$trees))
  expect_true(RBeast::is_trees_posterior(posterior_3$trees))
  expect_true(RBeast::is_trees_posterior(posterior_4$trees))

  # All same posteriors are identical
  expect_true(are_identical_trees_posteriors(posterior_1$trees, posterior_1$trees)) # nolint
  expect_true(are_identical_trees_posteriors(posterior_2$trees, posterior_2$trees)) # nolint
  expect_true(are_identical_trees_posteriors(posterior_3$trees, posterior_3$trees)) # nolint
  expect_true(are_identical_trees_posteriors(posterior_4$trees, posterior_4$trees)) # nolint

  # All different posteriors are different
  expect_false(are_identical_trees_posteriors(posterior_1$trees, posterior_2$trees)) # nolint
  expect_false(are_identical_trees_posteriors(posterior_1$trees, posterior_3$trees)) # nolint
  expect_false(are_identical_trees_posteriors(posterior_1$trees, posterior_4$trees)) # nolint
  expect_false(are_identical_trees_posteriors(posterior_2$trees, posterior_3$trees)) # nolint
  expect_false(are_identical_trees_posteriors(posterior_2$trees, posterior_4$trees)) # nolint
  expect_false(are_identical_trees_posteriors(posterior_3$trees, posterior_4$trees)) # nolint

})


test_that("are_identical_trees_posteriors: use from local simulation", {

  base_filename <- "are_identical_trees_posteriors"
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
    nspp = 10,
    base_filename = base_filename,
    rng_seed = 42,
    beast_jar_path = beast_jar_path,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  posterior_2 <- alignment_to_beast_posterior(
    alignment_dnabin = alignment,
    nspp = 10,
    base_filename = base_filename,
    rng_seed = 42,
    beast_jar_path = beast_jar_path,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  posterior_3 <- alignment_to_beast_posterior(
    alignment_dnabin = alignment,
    nspp = 10,
    base_filename = base_filename,
    rng_seed = 314,
    beast_jar_path = beast_jar_path,
    skip_if_output_present = FALSE,
    verbose = FALSE
  )

  expect_true(RBeast::is_trees_posterior(posterior_1$trees))
  expect_true(RBeast::is_trees_posterior(posterior_2$trees))
  expect_true(RBeast::is_trees_posterior(posterior_3$trees))
  expect_true(are_identical_trees_posteriors(posterior_1$trees, posterior_1$trees)) # nolint
  expect_true(are_identical_trees_posteriors(posterior_1$trees, posterior_2$trees)) # nolint
  expect_true(are_identical_trees_posteriors(posterior_2$trees, posterior_2$trees)) # nolint
  expect_true(are_identical_trees_posteriors(posterior_3$trees, posterior_3$trees)) # nolint
  expect_false(are_identical_trees_posteriors(posterior_1$trees, posterior_3$trees)) # nolint
  expect_false(are_identical_trees_posteriors(posterior_2$trees, posterior_3$trees)) # nolint
})

test_that("are_identical_trees_posteriors: abuse", {

  filename <- find_path("toy_example_4.RDa")
  file <- read_file(filename)
  posterior_1 <- get_posterior_by_index(file, 1)$trees
  posterior_2 <- get_posterior_by_index(file, 2)$trees
  posterior_3 <- get_posterior_by_index(file, 3)$trees
  posterior_4 <- get_posterior_by_index(file, 4)$trees

  expect_error(
    are_identical_trees_posteriors(
      p = NULL, q = NULL,
      verbose = "not TRUE nor FALSE"
    ),
    "verbose should be TRUE or FALSE"
  )
  expect_error(
    are_identical_trees_posteriors(
      p = "not a BEAST2 posterior",
      q = posterior_2,
      verbose = FALSE
    ),
    "p must be a BEAST2 posterior"
  )

  expect_error(
    are_identical_trees_posteriors(
      p = posterior_1,
      q = "not a BEAST2 posterior",
      verbose = FALSE
    ),
    "q must be a BEAST2 posterior"
  )

})
