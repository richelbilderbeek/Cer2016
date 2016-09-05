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
    nspp = 10,
    n_beast_runs = 1,
    filename = filename
  )
  add_pbd_output(filename)

  # Cannot add alignment without species trees
  expect_error(
    add_alignments(filename),
    "need species_trees at index 1"
  )

  add_species_trees(filename = filename)

  # Precondition normal use
  expect_error(
    get_alignment(file = read_file(filename), sti = 1, ai = 1),
    "alignment absent at index 1"
  )
  expect_error(
    get_alignment(file = read_file(filename), sti = 2, ai = 1),
    "alignment absent at index 2"
  )

  # Normal use takes place
  add_alignments(filename = filename)

  # Postcondition normal use
  expect_identical(
    has_alignments(read_file(filename = filename)),
    rep(TRUE, times = 2)
  )
  expect_true(is_alignment(get_alignment(file = read_file(filename = filename), sti = 1, ai = 1))) # nolint
  expect_true(is_alignment(get_alignment(file = read_file(filename = filename), sti = 2, ai = 1))) # nolint

  # Cleaning up
  file.remove(filename)
  expect_false(file.exists(filename))
})


test_that("add_alignment: abuse", {

  expect_error(
    add_alignments(filename = "inva.lid"),
    "invalid file"
  )
})
