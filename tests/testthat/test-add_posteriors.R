context("add_posteriors")

test_that("posteriors are added", {
  filename <- "test-add_posteriors.RDa"
  filename_trees <- "test-add_posteriors_1_1_1.trees"
  filename_xml <- "test-add_posteriors_1_1_1.xml"
  filename_xml_state <- "test-add_posteriors_1_1_1.xml.state"
  filename_log <- "test-add_posteriors_1_1_1.log"

  # Pre clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  if (file.exists(filename_trees)) {
    file.remove(filename_trees)
  }
  if (file.exists(filename_xml)) {
    file.remove(filename_xml)
  }
  if (file.exists(filename_xml_state)) {
    file.remove(filename_xml_state)
  }
  if (file.exists(filename_log)) {
    file.remove(filename_log)
  }

  expect_equal(file.exists(filename), FALSE)
  expect_equal(file.exists(filename_trees), FALSE)
  expect_equal(file.exists(filename_xml), FALSE)
  expect_equal(file.exists(filename_xml_state), FALSE)
  expect_equal(file.exists(filename_log), FALSE)

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
  add_species_trees(
    filename = filename,
    verbose = FALSE,
    add_outgroup = TRUE
  )
  add_alignments(
    filename = filename,
    verbose = FALSE
  )

  expect_equal(file.exists(filename_trees), FALSE)
  add_posteriors(
    filename = filename,
    skip_if_output_present = FALSE,
    verbose = TRUE
  )
  #expect_equal(file.exists(filename_trees), TRUE) # nolint
  expect_equal(file.exists(filename_xml), TRUE)
  #expect_equal(file.exists(filename_xml_state), TRUE) # nolint
  #expect_equal(file.exists(filename_log), TRUE) # nolint

  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  if (file.exists(filename_trees)) {
    file.remove(filename_trees)
  }
  if (file.exists(filename_xml)) {
    file.remove(filename_xml)
  }
  if (file.exists(filename_xml_state)) {
    file.remove(filename_xml_state)
  }
  if (file.exists(filename_log)) {
    file.remove(filename_log)
  }

  expect_equal(file.exists(filename), FALSE)
  expect_equal(file.exists(filename_trees), FALSE)
  expect_equal(file.exists(filename_xml), FALSE)
  expect_equal(file.exists(filename_xml_state), FALSE)
  expect_equal(file.exists(filename_log), FALSE)

})
