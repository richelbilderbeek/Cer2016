context("collect_file_nrbss")

test_that("collect_file_nrbss: use on #3", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_file_nrbss(filename)
  expect_equal(
    names(df),
    c("species_tree", "alignment", "beast_run", "state", "nrbs")
  )
  expect_equal(nrow(df), 80)
})

test_that("collect_file_nrbss: use on #4", {
  filename <- find_path("toy_example_4.RDa")
  df <- collect_file_nrbss(filename)
  expect_equal(
    names(df),
    c("species_tree", "alignment", "beast_run", "state", "nrbs")
  )
  expect_equal(nrow(df), 80)
})

test_that("collect_file_nrbss: abuse", {

  expect_error(
    collect_file_nrbss(c("1.RDa", "2.Rda")),
    "there must be exactly one filename supplied" # nolint
  )

  expect_error(
    collect_file_nrbss(filename = "inva.lid"),
    "invalid file 'inva.lid'"
  )

  expect_error(
    collect_file_nrbss(
      filename = "1.RDa",
      verbose = "Not true nor false"
    ),
    "verbose should be TRUE or FALSE"
  )

})
