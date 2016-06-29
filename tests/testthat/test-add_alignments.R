context("add_alignment")

test_that("alignment is added", {
  filename <- "test-add_alignment.RDa"
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
    mcmc_chainlength = 10000,
    n_beast_runs = 1,
    filename = filename
  )
  add_pbd_output(filename)

  # Cannot add alignment without species trees
  expect_error(
    add_alignments(filename),
    "add_alignments: need species_trees at index 1"
  )

  add_species_trees(
    filename = filename,
    verbose = FALSE
  )

  # Precondition normal use
  expect_error(
    get_alignment_by_index(file = read_file(filename), alignment_index = 1),
    "get_alignment_by_index: alignment absent at index 1"
  )

  # Normal use takes place
  add_alignments(
    filename = filename,
    verbose = TRUE
  )

  # Postcondition normal use
  file <- read_file(filename = filename)
  expect_true(is_alignment(get_alignment_by_index(file = file, alignment_index = 1)))

  # Cannot add alignment twice, only gives a warning
  expect_message(
    add_alignments(filename, verbose = TRUE),
    "add_alignments: already got alignment"
  )

  # Cleaning up
  file.remove(filename)
  expect_false(file.exists(filename))
})


test_that("add_alignment: abuse", {

  expect_error(
    add_alignments(
      filename = find_path("toy_example_1.RDa"),
      verbose = "not TRUE nor FALSE"
    ),
    "add_alignments: verbose should be TRUE or FALSE"
  )
  expect_error(
    add_alignments(
      filename = "inva.lid",
      verbose = FALSE
    ),
    "add_alignments: invalid file"
  )
})
