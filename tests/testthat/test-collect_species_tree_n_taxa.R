context("collect_species_tree_n_taxa")

test_that("collect_species_tree_n_taxa: basic use", {

  filename <- find_path("toy_example_1.RDa")
  df <- collect_species_tree_n_taxa(filename)
  expect_equal(names(df), c("n_taxa"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
})

test_that("collect_species_tree_n_taxa: abuse", {

  filename <- find_path("toy_example_1.RDa")

  expect_error(
    collect_species_tree_n_taxa(
      filename = "inva.lid",
      verbose = FALSE
    ),
    "collect_species_n_taxa: invalid filename 'inva.lid'"
  )

  expect_error(
    collect_species_tree_n_taxa(
      filename = filename,
      verbose = "invalid"
    ),
    "collect_species_n_taxa: verbose should be TRUE or FALSE"
  )
})
