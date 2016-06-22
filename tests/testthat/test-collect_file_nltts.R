context("collect_file_nltts")

test_that("collect_file_nltts: use", {
  dt <- 0.1
  filename <- find_path("toy_example_3.RDa")
  df <- collect_file_nltts(filename, dt = dt)
  expect_equal(
    names(df),
    c("species_tree_nltts", "posterior_nltts")
  )
  expect_equal(
    names(df$species_tree_nltts),
    c("species_tree", "t", "nltt")
  )
  expect_true(nrow(df$species_tree_nltts) > 2)
  expect_true(nrow(df$posterior_nltts) > 80)
})

test_that("collect_file_nltts: abuse", {

  expect_error(
    collect_file_nltts(filename = "NA", verbose = "not TRUE nor FALSE"),
    "collect_file_nltts: verbose should be TRUE or FALSE"
  )

  expect_error(
    collect_file_nltts(filename = c("inva", "lid")),
    "collect_file_nltts: there must be exactly one filename supplied"
  )

  expect_error(
    collect_file_nltts(filename = "inva.lid"),
    "collect_file_nltts: invalid file '"
  )

})
