context("do_simulation")

test_that("do_simulation: use", {
  filename <- "test-do_simulation.RDa"
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

  expect_silent(do_simulation(filename = filename))
  file.remove(filename)

})

test_that("do_simulation: create full toy_example_x.RDa", {
  if (1 == 2) {
    filenames <- paste0("toy_example_", 1:4, ".RDa")
    create_test_parameter_files(filenames = filenames)
    for (filename in filenames) {
      do_simulation(filename = filename)
    }
  }
})

test_that("do_simulation: abuse", {
  expect_error(
    do_simulation(filename = filename, verbose = "not TRUE nor FALSE"),
    "verbose should be TRUE or FALSE"
  )
  expect_error(
    do_simulation(filename = c("inva", "lid")),
    "supply exactly one parameter filename"
  )

  expect_error(
    do_simulation(filename = "inva.lid"),
    "filename must be a valid file"
  )
})
