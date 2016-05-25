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
  add_species_trees_with_outgroup(
    filename = filename,
    verbose = FALSE
  )
  expect_equal(
    is.na(read_file(filename = filename)$alignments),
    TRUE
  )
  add_alignments(
    filename = filename,
    verbose = FALSE
  )
  file <- read_file(filename = filename)
  expect_equal(class(file$alignments[[1]]) == "list", TRUE)
  expect_equal(class(file$alignments[[1]][[1]]) == "DNAbin", TRUE)
  file.remove(filename)
  expect_equal(file.exists(filename), FALSE)
})
