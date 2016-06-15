context("collect_n_species_trees")

test_that("collect_n_species_trees: use case #1", {
  filename <- find_path("toy_example_1.RDa")
  df <- collect_n_species_trees(filename)
  expect_equal(names(df), c("n_species_trees"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
  expect_equal(df$n_species_trees[1], 1)
})

test_that("collect_n_species_trees: use case #2", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_n_species_trees(filename)
  expect_equal(names(df), c("n_species_trees"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
  expect_equal(df$n_species_trees[1], 2)
})

test_that("collect_n_species_trees: empty_file", {
  # An empty file does not have sampled species trees yet
  filename <- "test-collect_n_species_trees.RDa"
  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.1,
    siri = 0.1,
    scr = 0.1,
    erg = 0.1,
    eri = 0.1,
    age = 15,
    n_species_trees_samples = 2,
    mutation_rate = 0.01,
    n_alignments = 2,
    sequence_length = 1000,
    mcmc_chainlength = 10000,
    n_beast_runs = 2,
    filename = filename
  )
  df <- collect_n_species_trees(filename)
  expect_equal(names(df), c("n_species_trees"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
  expect_equal(df$n_species_trees[1], 0)
})
