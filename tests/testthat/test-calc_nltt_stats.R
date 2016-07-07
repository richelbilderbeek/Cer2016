context("calc_nltt_stats")

test_that("calc_nltt_stats use", {
  nltt_stats <- calc_nltt_stats(
    phylogeny = ape::rcoal(10),
    others = c(ape::rcoal(10), ape::rcoal(10)),
    dt = 0.1
  )
  expect_equal(names(nltt_stats), c("id", "nltt_stat"))
  expect_equal(nrow(nltt_stats), 2)
})

test_that("calc_nltt_stats: abuse", {

  expect_error(
    nltt_stats <- calc_nltt_stats(
      phylogeny = "Not a phylogeny",
      others = c(ape::rcoal(10), ape::rcoal(10)),
      dt = 0.1
    ),
    "nltt_stats: phylogeny must be a phylogeny"
  )

  expect_error(
    nltt_stats <- calc_nltt_stats(
      phylogeny = ape::rcoal(10),
      others = c(),
      dt = 0.1
    ),
    "nltt_stats: must supply others"
  )

  expect_error(
    nltt_stats <- calc_nltt_stats(
      phylogeny = ape::rcoal(10),
      others = c(ape::rcoal(10), "Not a phylogeny"),
      dt = 0.1
    ),
    "nltt_stats: others must be phylogenies"
  )

  expect_error(
    nltt_stats <- calc_nltt_stats(
      phylogeny = ape::rcoal(10),
      others = c(ape::rcoal(10), ape::rcoal(10)),
      dt = 0.0
    ),
    "nltt_stats: dt must be more than zero"
  )

  expect_error(
    nltt_stats <- calc_nltt_stats(
      phylogeny = ape::rcoal(10),
      others = c(ape::rcoal(10), ape::rcoal(10)),
      dt = 1.0
    ),
    "nltt_stats: dt must be less than one"
  )

})
