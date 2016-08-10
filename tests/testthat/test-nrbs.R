context("nrbs")

test_that("nrbs: use", {
  p <- ape::rcoal(10)
  q <- ape::rcoal(10)
  difference <- nrbs(p, q)
  expect_true(difference >= 0.0)
})

test_that("nrbs: identical trees have no difference", {
  phylogeny1 <- ape::rcoal(10)
  phylogeny2 <- phylogeny1
  difference <- nrbs(phylogeny1, phylogeny2)
  expect_true(difference >= 0.0    )
  expect_true(difference  < 0.00001)
})

test_that("nrbs: abuse", {

  expect_error(
    nrbs(phylogeny1 = "no phylo", phylogeny2 = ape::rcoal(5)),
    "parameter 'phylogeny1' must be of type 'phylo'"
  )
  expect_error(
    nrbs(phylogeny1 = ape::rcoal(5), phylogeny2 = "no phylo"),
    "parameter 'phylogeny2' must be of type 'phylo'"
  )

  expect_error(
    nrbs(phylogeny1 = ape::rcoal(5), phylogeny2 = ape::rcoal(4)),
    "phylogenies must have same number of tips"
  )

  p <- ape::rcoal(5)
  p$tip.label <- paste0("s", 1:5)
  q <- ape::rcoal(5)
  expect_error(
    nrbs(phylogeny1 = p, phylogeny2 = q),
    "phylogenies must have same tip labels"
  )

  p <- ape::rcoal(5)
  q <- ape::rcoal(5)
  new_labels <- c(NA, paste0("s", 1:4))
  p$tip.label <- new_labels
  q$tip.label <- new_labels

  expect_error(
    nrbs(phylogeny1 = p, phylogeny2 = q),
    "phylogeny #1 must not have any NA tip label"
  )

})
