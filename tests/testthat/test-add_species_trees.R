context("add_species_trees")

test_that("add_species_trees: use", {
  filename <- "test-add_species_trees.RDa"
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
  add_pbd_output(filename)
  expect_true(
    is.na(read_file(filename)$species_trees[1])
  )

  add_species_trees(filename = filename)

  expect_false(
    is.na(read_file(filename)$species_trees[1])
  )
  file.remove(filename)
  expect_false(file.exists(filename))
})


test_that("add_species_trees: abuse", {

  expect_error(
    add_species_trees(filename = "inva.lid"),
    "invalid file"
  )

  filename <- "test-add_species_trees.RDa"
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
  expect_error(
    add_species_trees(filename = filename),
    paste0("file '", filename, "' needs a pbd_output")
  )
  file.remove(filename)
})
