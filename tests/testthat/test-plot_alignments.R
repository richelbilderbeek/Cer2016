context("plot_alignments")

test_that("plot_alignments: basic use", {

  pdf_filename <- "Rplots.pdf"
  if (file.exists(pdf_filename)) {
    file.remove(pdf_filename)
  }

  plot_alignments(filename = find_path("toy_example_1.RDa"))

  expect_true(file.exists(pdf_filename))
  if (file.exists(pdf_filename)) {
    file.remove(pdf_filename)
  }
  expect_false(file.exists(pdf_filename))
})

test_that("plot_alignments: abuse", {
  expect_error(
    plot_alignments(filename = "inva.lid"),
    "invalid filename"
  )
})
