context("collect_file_gammas")

test_that("collect_file_gammas: basic test", {
  skip("First recreate toy examples")

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

test_that("collect_file_gammas: abuse", {

  expect_error(
    collect_file_gammas(c("1.RDa", "2.Rda")),
    "collect_file_gammas: there must be exactly one filename supplied" # nolint
  )

  expect_error(
    collect_file_gammas(filename = "inva.lid"),
    "collect_file_gammas: invalid file 'inva.lid'"
  )

  expect_error(
    collect_file_gammas(
      filename = "1.RDa",
      verbose = "Not true nor false"
    ),
    "collect_file_gammas: verbose should be TRUE or FALSE"
  )

})
