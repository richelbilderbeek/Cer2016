context("collect_file_gammas")

test_that("collect_file_gammas: basic test", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_file_gammas(filename)
  expect_equal(
    names(df),
    c("species_tree_gammas", "posterior_gammas")
  )
  expect_equal(
    names(df$species_tree_gammas),
    c("species_tree", "gamma_stat")
  )
  expect_equal(nrow(df$species_tree_gammas), 2)
  expect_equal(nrow(df$posterior_gammas), 80)
})
