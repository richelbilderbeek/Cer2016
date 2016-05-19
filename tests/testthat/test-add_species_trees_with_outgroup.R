context("add_species_trees_with_outgroup")

## TODO: Rename context
## TODO: Add more tests

test_that("multiplication works", {
  filename <- "test-add_pbd_output.RDa"
  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    n_species_trees_samples = 1,
    add_outgroup = TRUE,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = 1,
    filename = filename
  )
  add_pbd_output(filename)
  expect_equal(
    is.na(read_file(filename)$species_trees_with_outgroup[1]),
    TRUE
  )
  add_species_trees_with_outgroup(filename)
  expect_equal(
    is.na(read_file(filename)$species_trees_with_outgroup[1]),
    FALSE
  )
  file.remove(filename)
  expect_equal(file.exists(filename), FALSE)

})
