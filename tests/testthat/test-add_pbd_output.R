context("add_pbd_output")

test_that("pbd_output is added", {
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
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = 1,
    filename = filename
  )
  expect_true(file.exists(filename))
  expect_false(
    is_pbd_sim_output(read_file(filename)$pbd_output)
  )
  add_pbd_output(filename)
  expect_true(
    is_pbd_sim_output(read_file(filename)$pbd_output)
  )
  file.remove(filename)
  expect_false(file.exists(filename))
})
