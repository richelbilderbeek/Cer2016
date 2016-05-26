context("alignment_to_beast_posterior")

test_that("alignment_to_beast_posterior: basic", {
  base_filename <- "test-alignment_to_beast_posterior"
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

  posterior <- alignment_to_beast_posterior(
    alignment_dnabin = alignment,
    mcmc_chainlength = 10000,
    base_filename = base_filename,
    rng_seed = 42,
    beast_bin_path = "",
    beast_jar_path = find_beast_jar_path(),
    skip_if_output_present = FALSE,
    verbose = FALSE
  )
  expect_equal(
    names(posterior),
    paste0("STATE_", seq(from = 1000, to = 10000, by = 1000))
  )
  expect_equal(
    class(posterior$STATE_1000),
    "phylo"
  )
  expect_equal(file.exists(beast_log_filename), TRUE)
  expect_equal(file.exists(beast_trees_filename), TRUE)
  expect_equal(file.exists(beast_state_filename), TRUE)

  # Cleaning up
  if (file.exists(beast_log_filename)) {
    file.remove(beast_log_filename)
  }
  if (file.exists(beast_trees_filename)) {
    file.remove(beast_trees_filename)
  }
  if (file.exists(beast_state_filename)) {
    file.remove(beast_state_filename)
  }
})
