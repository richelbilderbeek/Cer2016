context("plot_extant_incipient_tree")

test_that("plot_extant_incipient_tree: use", {

  plot_extant_incipient_tree(filename = find_path("toy_example_1.RDa"))

})

test_that("plot_extant_incipient_tree: abuse", {

  expect_error(
    plot_extant_incipient_tree(filename = "inva.lid"),
    "plot_extant_incipient_tree: file 'inva.lid' is invalid"
  )
})
