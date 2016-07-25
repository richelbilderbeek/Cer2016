context("calc_nltt_stats")

test_that("calc_nltt_stats use", {
  nltt_stats <- calc_nltt_stats(
    phylogeny = ape::rcoal(10),
    others = c(ape::rcoal(10), ape::rcoal(10))
  )
  expect_equal(names(nltt_stats), c("id", "nltt_stat"))
  expect_equal(nrow(nltt_stats), 2)
})

test_that("calc_nltt_stats: abuse", {

  expect_error(
    nltt_stats <- calc_nltt_stats(
      phylogeny = "Not a phylogeny",
      others = c(ape::rcoal(10), ape::rcoal(10))
    ),
    "nltt_stats: phylogeny must be a phylogeny"
  )

  expect_error(
    nltt_stats <- calc_nltt_stats(
      phylogeny = ape::rcoal(10),
      others = c()
    ),
    "nltt_stats: must supply others"
  )

  expect_error(
    nltt_stats <- calc_nltt_stats(
      phylogeny = ape::rcoal(10),
      others = c(ape::rcoal(10), "Not a phylogeny")
    ),
    "nltt_stats: others must be phylogenies"
  )
})
