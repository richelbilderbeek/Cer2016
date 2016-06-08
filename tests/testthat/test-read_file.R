context("read_file")

test_that("read_file works", {
  skip("First recreate toy examples")

  file <- read_file(find_path("toy_example_1.RDa"))

  expect_equal(class(file), "list")
  expect_equal(names(file),
    c(
      "parameters",
      "pbd_output",
      "species_trees_with_outgroup",
      "alignments",
      "posteriors"
    )
  )

})

test_that("read_file abuse", {
  expect_error(
    read_file(filename = "inva.lid"),
    "read_file: file 'inva.lid' does not exist"
  )
  expect_error(
    read_file(filename = c("1.RDa", "2.RDa")),
    "read_file: must supply 'read_file' with one filename"
  )
})
