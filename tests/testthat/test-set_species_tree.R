context("set_species_tree_by_index")

test_that("set_species_tree_by_index: use", {
  file <- read_file(find_path("toy_example_1.RDa"))
  st <- get_species_tree_by_index(file = file, sti = 1)
  expect_true(is_phylogeny(st))
  st_new <- ape::rcoal(10)

  expect_false(are_identical_phylogenies(st, st_new))
  file <- set_species_tree_by_index(
    file = file,
    sti = 1,
    species_tree = st_new
  )
  st_new_again <- get_species_tree_by_index(file = file, sti = 1)
  expect_true(are_identical_phylogenies(st_new, st_new_again))
})


test_that("set_species_tree_by_index: abuse", {

  expect_error(
    set_species_tree_by_index(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 0,
      species_tree = ape::rcoal(10)
    ),
    "index must be at least 1"
  )

  expect_error(
    set_species_tree_by_index(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 3,
      species_tree = ape::rcoal(10)
    ),
    "index must be less than number of species_trees"
  )

})
