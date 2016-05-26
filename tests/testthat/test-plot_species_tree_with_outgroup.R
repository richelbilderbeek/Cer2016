context("plot_species_tree_with_outgroup")

test_that("plot_species_tree_with_outgroup works", {

  plot_species_tree_with_outgroup(filename = find_path("toy_example_1.RDa"))
  expect_error(
    plot_species_tree_with_outgroup(filename = "inva.lid"),
    "plot_species_tree_with_outgroup: invalid filename"
  )

})
