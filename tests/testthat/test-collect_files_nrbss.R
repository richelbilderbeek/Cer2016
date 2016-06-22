context("collect_files_nrbss")

test_that("collect_files_nrbss: use", {

  filenames <- c(
    find_path("toy_example_3.RDa"),
    find_path("toy_example_4.RDa")
  )
  df <- collect_files_nrbss(filenames, verbose = TRUE)
  expect_equal(
    names(df),
    c("filenames", "species_tree", "alignment", "beast_run", "state", "nrbs")
  )
  expect_equal(nrow(df), 160)
})

test_that("collect_files_nrbss: abuse", {

  expect_error(
    collect_files_nrbss(filenames = "inval.lid", verbose = "TRUE nor FALSE"),
    "collect_files_nrbss: verbose should be TRUE or FALSE"
  )

  expect_error(
    collect_files_nrbss(filenames = c()),
    "collect_files_nrbss: there must be at least one filename supplied"
  )
})
