context("collect_file_nltts")

test_that("collect_file_nltts: basic test", {
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
  expect_equal(nrow(df$species_tree_nltts) > 2, TRUE)
  expect_equal(nrow(df$posterior_nltts) > 80, TRUE)
})
