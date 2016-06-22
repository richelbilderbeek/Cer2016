context("collect_files_n_alignments")

test_that("collect_files_n_alignments: basic use", {
  filenames <- c(
    find_path("toy_example_1.RDa"),
    find_path("toy_example_3.RDa")
  )
  df <- collect_files_n_alignments(filenames, verbose = FALSE)
  expect_equal(names(df), c("filenames", "n_alignments"))
  expect_equal(nrow(df), length(filenames))
  expect_equal(df$n_alignments, c(1, 4))
})

test_that("collect_n_alignments: abuse", {
  expect_error(
    collect_files_n_alignments(filename = "inva.lid", verbose = "TRUE nor FALSe"), # nolint
    "collect_files_n_alignments: verbose should be TRUE or FALSE"
  )

  expect_error(
    collect_files_n_alignments(filename = c()),
    "collect_files_n_alignments: there must be at least one filename supplied"
  )
})
