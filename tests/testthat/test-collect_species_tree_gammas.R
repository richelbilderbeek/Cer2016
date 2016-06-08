context("collect_species_tree_gammas")

test_that("collect_species_tree_gammas toy example 3", {
  filename <- find_path("toy_example_1.RDa")
  df <- collect_species_tree_gammas(filename)
  expect_equal(names(df),
    c("species_tree", "gamma_stat")
  )
  expect_equal(nrow(df), 1)
  expect_equal(df$gamma_stat, 0.005813035, tolerance = 0.0001)
})

test_that("collect_species_tree_gammas toy example 1", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_species_tree_gammas(filename)
  expect_equal(names(df),
    c("species_tree", "gamma_stat")
  )
  expect_equal(nrow(df), 2)
  expect_equal(df$gamma_stat[1], 0.8273239, tolerance = 0.0001)
  expect_equal(df$gamma_stat[2], 0.8273239, tolerance = 0.0001)
})
