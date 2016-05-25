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
  expect_equal(nrow(df$species_tree_nltts), 18)
  expect_equal(nrow(df$posterior_nltts), 540)
})
