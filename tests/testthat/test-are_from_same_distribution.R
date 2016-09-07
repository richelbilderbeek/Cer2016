context("are_from_same_distribution")

test_that("are_from_same_distribution: use", {
  set.seed(42)
  expect_true(
    are_from_same_distribution(
      runif(100),
      runif(100)
    )
  )
  set.seed(314)
  expect_false(
    are_from_same_distribution(
      runif(100),
      rnorm(100)
    )
  )
})

test_that("are_from_same_distribution: too small dataset", {
  # Only datasets of size zero give an error
  set.seed(42)
  expect_true(
    is.na(
      are_from_same_distribution(
        runif(0),
        runif(1)
      )
    )
  )

  expect_true(
    is.na(
      are_from_same_distribution(
        runif(1),
        runif(0)
      )
    )
  )
})

test_that("are_from_same_distribution: datasets of different sizes", {
  # Only datasets of size zero give an error
  set.seed(42)
  expect_true(
    is.na(
      are_from_same_distribution(
        runif(100),
        runif(1)
      )
    )
  )

  expect_true(
    is.na(
      are_from_same_distribution(
        runif(1),
        runif(0)
      )
    )
  )
})
