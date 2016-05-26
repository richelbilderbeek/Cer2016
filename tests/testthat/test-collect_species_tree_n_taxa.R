context("collect_species_tree_n_taxa")

test_that("collect_species_tree_n_taxa: basic use", {
  filename <- find_path("toy_example_1.RDa")
  df <- collect_species_tree_n_taxa(filename)
  expect_equal(names(df), c("n_taxa"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
})
