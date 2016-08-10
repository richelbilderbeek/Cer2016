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
  expect_true(
    identical(
      names(df$species_tree_nltts),
      c("filename", "species_tree", "t", "nltt")
    )
  )
  expect_true(
    identical(
      names(df$posterior_nltts),
      c(
        "filename", "species_tree", "alignment",
        "beast_run", "state", "t", "nltt"
      )
    )
  )
})


test_that("collect_files_nltts: abuse", {
  expect_error(
    collect_files_nltts(filenames = c(), verbose = "TRUE nor FALSE"),
    "verbose should be TRUE or FALSE"
  )

  expect_error(
    collect_files_nltts(filenames = c()),
    "there must be at least one filename supplied"
  )

})
