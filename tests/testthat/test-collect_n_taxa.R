context("collect_n_taxa")

test_that("collect_n_taxa: use", {
  phylogenies <- c(ape::rcoal(10), ape::rcoal(20))
  df <- collect_n_taxa(phylogenies)
  expect_equal(names(df), c("n_taxa"))
  expect_equal(df, data.frame(n_taxa = c(10, 20)))
})

test_that("collect_n_taxa: other uses", {
  expect_silent(
    collect_n_taxa(phylogenies = c(ape::rcoal(10), ape::rcoal(20)))
  )
  expect_silent(
    collect_n_taxa(phylogenies = ape::rmtree(N = 2, n = 10))
  )
})

test_that("collect_n_taxa: abuse", {
  expect_error(
    collect_n_taxa(phylogenies = c()),
    "there must be at least one phylogeny supplied"
  )
  expect_error(
    collect_n_taxa(phylogenies = "nonsense"),
    "phylogenies must be of class 'multiPhylo' or 'list'"
  )
  expect_error(
    collect_n_taxa(phylogenies = list("nonsense")),
    "phylogenies must be of type phylo"
  )
})
