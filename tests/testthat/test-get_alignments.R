context("get_alignments")

test_that("get_alignments: toy examples 1", {

  filename <- find_path("toy_example_1.RDa")
  file <- read_file(filename)
  alignments <- get_alignments(file)
  expect_equal(length(alignments), 2)
  expect_true(is_alignment(alignments[[1]][[1]]))
  expect_true(is_alignment(alignments[[2]][[1]]))
})

test_that("get_alignments: toy examples 3", {

  filename <- find_path("toy_example_3.RDa")
  file <- read_file(filename)
  alignments <- get_alignments(file)
  expect_equal(length(alignments), 4)
  expect_true(is_alignment(alignments[[4]][[1]]))
})


test_that("get_alignments: add one", {

  filename <- "test-get_alignments.RDa"
  n_alignments <- 1

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
    n_beast_runs = n_alignments,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  file <- read_file(filename)
  alignments <- get_alignments(file)
  n_species_trees <- 2
  expect_equal(length(alignments), n_alignments * n_species_trees)


  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))
})

test_that("get_alignments: add two", {

  filename <- "test-get_alignments.RDa"
  n_alignments <- 2

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
    n_alignments = n_alignments,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  alignments <- get_alignments(read_file(filename))
  n_species_trees <- 2
  expect_equal(length(alignments), n_alignments * n_species_trees)


  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))
})
