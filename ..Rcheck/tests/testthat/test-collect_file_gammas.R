context("collect_file_gammas")


test_that("collect_file_gammas for toy example 1", {
  filename <- find_path("toy_example_1.RDa")
  df <- collect_file_gammas(filename)
  expect_equal(names(df),
    c("species_tree_gammas", "posterior_gammas")
  )
  expect_equal(names(df$species_tree_gammas),
    c("species_tree", "gamma_stat")
  )
  expect_equal(nrow(df$species_tree_gammas), 1)
  expect_equal(nrow(df$posterior_gammas), 10)
})

test_that("collect_file_gammas for toy example 3", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_file_gammas(filename)
  expect_equal(names(df),
    c("species_tree_gammas", "posterior_gammas")
  )
  expect_equal(names(df$species_tree_gammas),
    c("species_tree", "gamma_stat")
  )
  expect_equal(nrow(df$species_tree_gammas), 2)
  expect_equal(nrow(df$posterior_gammas), 80)
})
