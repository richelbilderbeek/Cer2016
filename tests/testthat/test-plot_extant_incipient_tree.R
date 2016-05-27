context("plot_extant_incipient_tree")

test_that("multiplication works", {
  plot_extant_incipient_tree(filename = find_path("toy_example_1.RDa"))
  expect_error(
    plot_extant_incipient_tree(filename = "inva.lid"),
    "plot_extant_incipient_tree: file 'inva.lid' is invalid"
  )
})
