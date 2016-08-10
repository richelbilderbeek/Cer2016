context("read_file")

test_that("read_file works", {

  file <- read_file(find_path("toy_example_1.RDa"))

  expect_equal(class(file), "list")
  expect_equal(names(file),
    c(
      "parameters",
      "pbd_output",
      "species_trees",
      "alignments",
      "posteriors"
    )
  )

})

test_that("read_file abuse", {
  expect_error(
    read_file(filename = "inva.lid"),
    "file 'inva.lid' does not exist"
  )
  expect_error(
    read_file(filename = c("1.RDa", "2.RDa")),
    "must supply 'read_file' with one filename"
  )

  filename <- "test-read_file.RDa"
  write.csv(data.frame(), file = filename)
  expect_error(
    read_file(filename = filename),
    "error in readRDS of file with name"
  )
  file.remove(filename)

})
