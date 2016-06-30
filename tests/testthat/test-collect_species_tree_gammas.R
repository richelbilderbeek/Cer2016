context("collect_species_tree_gammas")

test_that("collect_species_tree_gammas toy example 1", {
  filename <- find_path("toy_example_1.RDa")
  df <- collect_species_tree_gammas(filename)
  expect_equal(names(df),
    c("species_tree", "gamma_stat")
  )
  expect_equal(nrow(df), 2)
  expect_equal(df$gamma_stat[1], 0.005813035, tolerance = 0.0001)
  expect_equal(df$gamma_stat[2], 0.005813035, tolerance = 0.0001)
  # expect_equal(df$gamma_stat[1], -0.7585369, tolerance = 0.0001) # nolint
  # expect_equal(df$gamma_stat[2], -0.7585369, tolerance = 0.0001) # nolint
})

test_that("collect_species_tree_gammas toy example 3", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_species_tree_gammas(filename)
  expect_equal(names(df),
    c("species_tree", "gamma_stat")
  )
  expect_equal(nrow(df), 2)
  expect_equal(df$gamma_stat[1], 0.8273239, tolerance = 0.0001)
  expect_equal(df$gamma_stat[2], 0.8273239, tolerance = 0.0001)
})

test_that("collect_species_tree_gammas: abuse", {
  expect_error(
    collect_species_tree_gammas(
      filename = "inva.lid", verbose = "TRUE nor FALSE"
    ),
    "collect_species_tree_gammas: verbose should be TRUE or FALSE"
  )

  expect_error(
    collect_species_tree_gammas(filename = "inva.lid"),
    "collect_species_tree_gammas: invalid file"
  )
})
