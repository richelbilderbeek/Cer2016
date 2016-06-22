context("nrbs")

test_that("inputs", {
  phylogeny <- ape::rcoal(10)
  string <- "Hellow"
  expect_error(
    nrbs(phylogeny1 = string, phylogeny2 = phylogeny),
    "nrbs: parameter 'phylogeny1' must be of type 'phylo'"
  )
  expect_error(
    nrbs(phylogeny1 = phylogeny, phylogeny2 = string),
    "nrbs: parameter 'phylogeny2' must be of type 'phylo'"
  )
})

test_that("identical trees have no difference", {
  phylogeny1 <- ape::rcoal(10)
  phylogeny2 <- phylogeny1
  difference <- nrbs(phylogeny1, phylogeny2)
  expect_true(difference >= 0.0    )
  expect_true(difference  < 0.00001)
})
