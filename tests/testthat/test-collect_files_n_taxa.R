context("collect_files_n_taxa")

test_that("collect_files_n_taxa: basic", {

  filenames <- c(
    find_path("toy_example_1.RDa"),
    find_path("toy_example_2.RDa")
  )
  df <- collect_files_n_taxa(filenames, verbose = FALSE)
  expect_equal(names(df), c("filename", "n_taxa"))
  expect_equal(nrow(df), length(filenames))
  expect_equal(is.na(df$n_taxa), rep(FALSE, 2))
})

test_that("collect_files_n_taxa: abuse", {
  expect_error(
    collect_files_n_taxa(filename = "inva.lid", verbose = "TRUE nor FALSe"),
    "collect_files_n_taxa: verbose should be TRUE or FALSE"
  )

  expect_error(
    collect_files_n_taxa(filename = c()),
    "collect_files_n_taxa: there must be at least one filename supplied"
  )
})
