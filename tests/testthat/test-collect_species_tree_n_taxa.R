context("collect_species_tree_n_taxa")

test_that("collect_species_tree_n_taxa: basic use", {

  filename <- find_path("toy_example_1.RDa")
  df <- collect_species_tree_n_taxa(filename)
  expect_equal(names(df), c("n_taxa"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
})

test_that("collect_species_tree_n_taxa: abuse", {

  expect_error(
    collect_species_tree_n_taxa(
      filename = "inva.lid"
    ),
    "collect_species_n_taxa: invalid filename 'inva.lid'"
  )

  expect_error(
    collect_species_tree_n_taxa(
      filename = filename,
      verbose = "invalid"
    ),
    "collect_species_n_taxa: verbose should be TRUE or FALSE"
  )
})

test_that("collect_species_tree_n_taxa: empty file should raise error", {

  filename <- "test-collect_species_tree_n_taxa.RDa"
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

  # Mute output
  sink("/dev/null") # nolint
  df <- collect_species_tree_n_taxa(filename = filename, verbose = TRUE)
  sink() # nolint

  expect_equal(is.na(df$n_taxa[1]), TRUE)
  file.remove(filename)
})
