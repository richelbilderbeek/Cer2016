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
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10,
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

test_that("add_pbd_output: add twice", {

  filename <- "test-add_pbd_output.RDa"
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
  testit::assert(is_pbd_sim_output(read_file(filename)$pbd_output))

  expect_message(
    add_pbd_output(filename = filename, verbose = TRUE),
    "file already has a pbd_output"
  )
  file.remove(filename)
  expect_false(file.exists(filename))

})



test_that("add_pbd_output: demonstrate PBD::pbd_sim to freeze", {

  if (1 == 2) {
    filename <- "test-add_pbd_output.RDa"

    # If speciation-initiation is zero, and extinction non-zero,
    # it is nearly impossible to create an incipient species tree
    # with two taxa (which is the number of taxa at which it starts)
    save_parameters_to_file(
      rng_seed = 42,
      sirg = 0.0,
      siri = 0.0,
      scr = 0.0,
      erg = 2.0,
      eri = 2.0,
      age = 5,
      mutation_rate = 0.1,
      n_alignments = 1,
      sequence_length = 10,
      nspp = 10,
      n_beast_runs = 1,
      filename = filename
    )

    # Freeze
    add_pbd_output(filename, verbose = TRUE)

    file.remove(filename)
    expect_false(file.exists(filename))
  }
})



test_that("add_pbd_output: abuse", {

  expect_error(
    add_pbd_output(
      filename = find_path("toy_example_1.RDa"),
      verbose = "not TRUE nor FALSE"
    ),
    "verbose should be TRUE or FALSE"
  )

  expect_error(
    add_pbd_output(
      filename = "inval.lid",
    ),
    "invalid filename"
  )

})
