context("plot_species_tree_nltt")

test_that("plot_species_tree_nltt: use", {

  plot_species_tree_nltt(
    filename = find_path("toy_example_1.RDa"),
    dt = 0.1
  )
})

test_that("plot_species_tree_nltt: abuse", {

  expect_error(
    plot_species_tree_nltt(filename = "inva.lid"),
    "plot_species_tree_nltt: invalid filename"
  )
})
