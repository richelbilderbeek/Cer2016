context("collect_files_nltts")

test_that("collect_files_nltts: basic", {
  filenames <- c(
    find_path("toy_example_1.RDa"),
    find_path("toy_example_2.RDa"),
    find_path("toy_example_3.RDa"),
    find_path("toy_example_4.RDa")
  )

  df <- collect_files_nltts(filenames, dt = 0.5, verbose = FALSE)
  expect_equal(names(df),
    c("species_tree_nltts", "posterior_nltts")
  )
  expect_equal(nrow(df$species_tree_nltts), 24)
  expect_equal(nrow(df$posterior_nltts), 600)
})


test_that("collect_files_nltts: abuse", {
  expect_error(
    collect_files_nltts(filenames = c(), verbose = "TRUE nor FALSE"),
    "collect_files_nltts: verbose should be TRUE or FALSE"
  )

  expect_error(
    collect_files_nltts(filenames = c()),
    "collect_files_nltts: there must be at least one filename supplied"
  )

})
