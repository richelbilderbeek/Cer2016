context("save_parameters_to_file")

test_that("save_parameters_to_file", {
  filename <- "test-save_parameters_to_file.RDa"
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
  expect_true(file.exists(filename))
  expect_true(is_valid_file(filename))
  file.remove(filename)
  expect_false(file.exists(filename))
})
