context("plot_species_tree")

test_that("plot_species_tree: use", {

  plot_species_tree(filename = find_path("toy_example_1.RDa"))

})

test_that("plot_species_tree: abuse", {
  expect_error(
    plot_species_tree(filename = "inva.lid"),
    "plot_species_tree: invalid filename"
  )
})
