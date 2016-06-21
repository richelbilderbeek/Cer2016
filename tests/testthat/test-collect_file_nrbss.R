context("collect_file_nrbss")

test_that("collect_file_nrbss: use", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_file_nrbss(filename)
  expect_equal(
    names(df),
    c("species_tree", "beast_run", "state", "nrbs")
  )
  df
  testit::assert(nrow(df) == 40)
})

test_that("collect_file_nrbss: abuse", {

  expect_error(
    collect_file_nrbss(c("1.RDa", "2.Rda")),
    "collect_file_nrbss: there must be exactly one filename supplied" # nolint
  )

  expect_error(
    collect_file_nrbss(filename = "inva.lid"),
    "collect_file_nrbss: invalid file 'inva.lid'"
  )

  expect_error(
    collect_file_nrbss(
      filename = "1.RDa",
      verbose = "Not true nor false"
    ),
    "collect_file_nrbss: verbose should be TRUE or FALSE"
  )

})

