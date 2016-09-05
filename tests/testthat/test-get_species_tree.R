context("get_species_tree_by_index")

test_that("get_species_tree_by_index: #1", {
  file <- read_file(find_path("toy_example_1.RDa"))
  sti <- 1
  species_tree <- get_species_tree_by_index(file = file, sti = sti)
  expect_true(is_phylogeny(species_tree))
})

test_that("get_species_tree_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  sti <- 2
  species_tree <- get_species_tree_by_index(file = file, sti = sti)
  expect_true(is_phylogeny(species_tree))
  expect_true(
    identical(
      species_tree,
      get_species_tree_by_index(file, sti = sti)
    )
  )
})

test_that("set_species_tree_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  species_tree_1 <- get_species_tree_by_index(file, 1)
  species_tree_2 <- get_species_tree_by_index(file, 2)
  expect_true(is_phylogeny(species_tree_1))
  expect_true(is_phylogeny(species_tree_2))

  # All same species_trees are identical
  expect_true(identical(species_tree_1, species_tree_1))
  expect_true(identical(species_tree_2, species_tree_2))

  # All different species_trees are different
  expect_false(identical(species_tree_1, species_tree_2))

  # Copy #1 over #2
  file <- set_species_tree_by_index(file, 2, species_tree_1)
  expect_true(
    identical(
      get_species_tree_by_index(file, 1),
      get_species_tree_by_index(file, 2)
    )
  )

})

test_that("get_species_tree_by_index from fresh file", {
  filename <- "test-get_species_tree.RDa"

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
    n_beast_runs = 1,
    filename = filename
  )

  file <- read_file(filename = filename)

  # No species_tree yet
  expect_error(
    get_species_tree_by_index(file, 1),
    "species_tree absent at index 1"
  )
  expect_error(
    get_species_tree_by_index(file, 2),
    "species_tree absent at index 2"
  )

  # Getting a species_tree
  species_tree <- phylogeny <- ape::rcoal(n = 5)
  other_species_tree <- ape::rcoal(n = 5)

  expect_true(is_phylogeny(species_tree))
  expect_true(is_phylogeny(other_species_tree))

  file <- set_species_tree_by_index(
    file = file,
    sti = 2,
    species_tree = species_tree
  )

  species_tree_again <- get_species_tree_by_index(
    file = file,
    sti = 2
  )

  expect_true(identical(species_tree, species_tree_again))
  expect_false(identical(species_tree, other_species_tree))

  file.remove(filename)
})


test_that("get_species_tree_by_index: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))

  expect_error(
    get_species_tree_by_index(file = file, sti = -314),
    "index must be at least 1"
  )

  expect_error(
    get_species_tree_by_index(file = file, sti = 42),
    "index must be less than number of species_trees"
  )

  file <- set_species_tree_by_index(file = file, sti = 1, species_tree = NA)
  expect_error(
    get_species_tree_by_index(file = file, sti = 1),
    "species_tree absent at index 1"
  )

})
