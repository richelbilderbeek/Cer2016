context("has_alignments")

test_that("has_alignments: minimum use case", {

  filename <- "test-has_alignments.RDa"

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
  add_species_trees(filename = filename)

  # Does not have alignments
  expect_equal(
    has_alignments(file = read_file(filename)),
    rep(FALSE, times = 2)
  )

  # Normal use takes place
  add_alignments(filename = filename)

  # Postcondition normal use
  expect_equal(
    has_alignments(file = read_file(filename)),
    rep(TRUE, times = 2)
  )
  # Cleaning up
  file.remove(filename)
  expect_false(file.exists(filename))
})
