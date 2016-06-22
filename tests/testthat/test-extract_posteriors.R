context("extract_posteriors")

test_that("get_posterior_by_index: #1", {
  file <- read_file(find_path("toy_example_1.RDa"))
  posterior_index <- 1
  posterior <- get_posterior_by_index(file, posterior_index)
  expect_true(is_beast_posterior(posterior))
})

test_that("get_posterior_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  posterior_index <- 4
  posterior <- get_posterior_by_index(file, posterior_index)
  expect_true(is_beast_posterior(posterior))
  expect_true(
    are_identical_posteriors(
      posterior,
      get_posterior_by_index(file, posterior_index)
    )
  )
})

test_that("set_posterior_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  posterior_1 <- get_posterior_by_index(file, 1)
  posterior_2 <- get_posterior_by_index(file, 2)
  posterior_3 <- get_posterior_by_index(file, 3)
  posterior_4 <- get_posterior_by_index(file, 4)
  expect_true(is_beast_posterior(posterior_1))
  expect_true(is_beast_posterior(posterior_2))
  expect_true(is_beast_posterior(posterior_3))
  expect_true(is_beast_posterior(posterior_4))
  expect_true(length(names(posterior_1)) > 1)
  expect_true(length(names(posterior_2)) > 1)
  expect_true(length(names(posterior_3)) > 1)
  expect_true(length(names(posterior_4)) > 1)

  expect_true(are_identical_posteriors(posterior_1, file$posterior[[1]][[1]]))
  expect_true(are_identical_posteriors(posterior_2, file$posterior[[2]][[1]]))
  expect_true(are_identical_posteriors(posterior_3, file$posterior[[3]][[1]]))
  expect_true(are_identical_posteriors(posterior_4, file$posterior[[4]][[1]]))

  if (1 == 2) {
    multiphylo_1 <- posterior_1
    multiphylo_2 <- posterior_2
    multiphylo_3 <- posterior_3
    multiphylo_4 <- posterior_4
    class(multiphylo_1) <- "multiPhylo"
    class(multiphylo_2) <- "multiPhylo"
    class(multiphylo_3) <- "multiPhylo"
    class(multiphylo_4) <- "multiPhylo"
    png("set_posterior_by_index_4_1.png")
    phangorn::densiTree(multiphylo_1, type = "cladogram", alpha = 1)
    dev.off()
    png("set_posterior_by_index_4_2.png")
    phangorn::densiTree(multiphylo_2, type = "cladogram", alpha = 1)
    dev.off()
    png("set_posterior_by_index_4_3.png")
    phangorn::densiTree(multiphylo_3, type = "cladogram", alpha = 1)
    dev.off()
    png("set_posterior_by_index_4_4.png")
    phangorn::densiTree(multiphylo_4, type = "cladogram", alpha = 1)
    dev.off()
  }

  # All same posteriors are identical
  saveRDS(object = posterior_1, file = "set_posterior_by_index_1.RDa")
  saveRDS(object = posterior_2, file = "set_posterior_by_index_2.RDa")
  saveRDS(object = posterior_3, file = "set_posterior_by_index_3.RDa")
  saveRDS(object = posterior_4, file = "set_posterior_by_index_4.RDa")

  expect_true(are_identical_posteriors(posterior_1, posterior_1))
  expect_true(are_identical_posteriors(posterior_2, posterior_2))
  expect_true(are_identical_posteriors(posterior_3, posterior_3))
  expect_true(are_identical_posteriors(posterior_4, posterior_4))

  # All different posteriors are different
  expect_false(are_identical_posteriors(file$posterior[[1]][[1]], file$posterior[[2]][[1]]))
  expect_false(are_identical_posteriors(file$posterior[[1]][[1]], file$posterior[[3]][[1]]))
  expect_false(are_identical_posteriors(file$posterior[[1]][[1]], file$posterior[[4]][[1]]))
  expect_false(are_identical_posteriors(file$posterior[[2]][[1]], file$posterior[[3]][[1]]))
  expect_false(are_identical_posteriors(file$posterior[[2]][[1]], file$posterior[[4]][[1]]))
  expect_false(are_identical_posteriors(file$posterior[[3]][[1]], file$posterior[[4]][[1]]))

  expect_false(are_identical_posteriors(posterior_1, posterior_2))
  expect_false(are_identical_posteriors(posterior_1, posterior_3))
  expect_false(are_identical_posteriors(posterior_1, posterior_4))
  expect_false(are_identical_posteriors(posterior_2, posterior_3))
  expect_false(are_identical_posteriors(posterior_2, posterior_4))
  expect_false(are_identical_posteriors(posterior_3, posterior_4))

  # Copy #1 over #2
  file <- set_posterior_by_index(file, 2, posterior_1)
  expect_true(
    are_identical_posteriors(
      get_posterior_by_index(file, 1),
      get_posterior_by_index(file, 2)
    )
  )

  # Copy #3 over #4
  file <- set_posterior_by_index(file, 4, posterior_3)
  expect_true(
    are_identical_posteriors(
      get_posterior_by_index(file, 3),
      get_posterior_by_index(file, 4)
    )
  )
})



test_that("extract_posteriors: add one", {

  filename <- "test-extract_posteriors.RDa"
  n_posteriors <- 1

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
    n_species_trees_samples = 1,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = n_posteriors,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  add_posteriors(filename = filename)
  file <- read_file(filename)
  posteriors <- extract_posteriors(file)
  expect_equal(length(posteriors), n_posteriors)


  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))
})

test_that("extract_posteriors: add two", {

  filename <- "test-extract_posteriors.RDa"
  n_posteriors <- 2

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
    n_species_trees_samples = 1,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    mcmc_chainlength = 10000,
    n_beast_runs = n_posteriors,
    filename = filename
  )
  add_pbd_output(filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  add_posteriors(filename = filename)

  posteriors <- extract_posteriors(read_file(filename))
  expect_equal(length(posteriors), n_posteriors)


  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))
})
