context("plot_species_tree_nltt")

test_that("plot_species_tree_nltt works", {
  skip("First recreate toy examples")

  plot_species_tree_nltt(
    filename = find_path("toy_example_1.RDa"),
    dt = 0.1
  )
  expect_equal(file.exists("Rplots.pdf", FALSE))

  expect_error(
    plot_species_tree_nltt(filename = "inva.lid"),
    "plot_species_tree_nltt: invalid filename"
  )
})
