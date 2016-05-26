context("plot_alignments")

test_that("plot_alignments: basic", {
  plot_alignments(filename = find_path("toy_example_1.RDa"))
  expect_error(
    plot_alignments(filename = "inva.lid"),
    "plot_alignments: invalid filename"
  )
})
