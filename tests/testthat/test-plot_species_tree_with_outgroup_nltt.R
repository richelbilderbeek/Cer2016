context("plot_species_tree_with_outgroup_nltt")

test_that("plot_species_tree_with_outgroup_nltt works", {

  plot_species_tree_with_outgroup_nltt(
    filename = find_path("toy_example_1.RDa"),
    dt = 0.1
  )
  expect_error(
    plot_species_tree_with_outgroup_nltt(filename = "inva.lid"),
    "plot_species_tree_with_outgroup_nltt: invalid filename"
  )
})
