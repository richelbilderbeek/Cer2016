context("collect_gamma_statistics")

test_that("collect_gamma_statistics: use", {
  expect_silent(
    collect_gamma_statistics(phylogenies = c(ape::rcoal(5)))
  )

  expect_silent(
    collect_gamma_statistics(c(ape::rcoal(5), ape::rcoal(5)))
  )
})

test_that("collect_gamma_statistics: abuse", {
  expect_error(
    collect_gamma_statistics(phylogenies = c()),
    "there must be at least one phylogeny supplied"
  )

  expect_error(
    collect_gamma_statistics(phylogenies = "not a phylogeny"),
    "phylogenies must be of class 'multiPhylo' or 'list', used 'character' instead" # nolint
  )

  expect_error(
    collect_gamma_statistics(phylogenies = list(c("no phylogenies"))),
    "phylogenies must be of type phylo, instead of 'character'" # nolint
  )

})
