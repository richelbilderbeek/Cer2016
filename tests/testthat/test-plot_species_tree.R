context("plot_species_tree")

test_that("plot_species_tree works", {

  plot_species_tree(filename = find_path("toy_example_1.RDa"))
  expect_error(
    plot_species_tree(filename = "inva.lid"),
    "plot_species_tree: invalid filename"
  )

})
