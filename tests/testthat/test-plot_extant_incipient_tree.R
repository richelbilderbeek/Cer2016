context("plot_extant_incipient_tree")

test_that("plot_extant_incipient_tree works", {
  skip("First recreate toy examples")
  plot_extant_incipient_tree(filename = find_path("toy_example_1.RDa"))
  expect_error(
    plot_extant_incipient_tree(filename = "inva.lid"),
    "plot_extant_incipient_tree: file 'inva.lid' is invalid"
  )
  expect_equal(file.exists("Rplots.pdf", FALSE))
})
