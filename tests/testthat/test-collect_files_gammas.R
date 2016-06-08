context("collect_files_gammas")

test_that("collect_files_gammas: basic test", {

  filenames <- c(
    find_path("toy_example_3.RDa"),
    find_path("toy_example_4.RDa")
  )
  df <- collect_files_gammas(filenames)
  expect_equal(
    names(df),
    c("species_tree_gamma_stats", "posterior_gamma_stats")
  )
  expect_equal(
    names(df$species_tree_gamma_stats),
    c("filenames", "species_tree", "gamma_stat")
  )
  expect_equal(nrow(df$species_tree_gamma_stats), 4)
  expect_equal(nrow(df$posterior_gamma_stats), 160)
})
