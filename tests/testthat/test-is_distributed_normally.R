context("is_distributed_normally")

test_that("is_distributed_normally: use", {


  # Create a normal disribution
  set.seed(42)
  nd <- rnorm(n = 1000, mean = 0.0, sd = 1.0)
  expect_true(is_distributed_normally(nd))

  # Create a non-normal disribution
  nnd <- runif(n = 1000, min = 0.0, max = 1.0)
  expect_false(is_distributed_normally(nnd))

  # Create a disribution of one value only, should result in NA
  r <- rep(x = 42, times = 100)
  testit::assert(is.na(is_distributed_normally(r)))

})

test_that("is_distributed_normally: abuse", {

  expect_error(
    is_distributed_normally(c(3, NA, 1, 4)),
    "is_distributed_normally: all values must be numeric"
  )

  expect_error(
    is_distributed_normally(c(3, "hello", 1, 4)),
    "is_distributed_normally: all values must be numeric"
  )

  expect_error(
    is_distributed_normally(c(3, 1)),
    "is_distributed_normally: sample size must be between 3 and 5000"
  )

  expect_error(
    is_distributed_normally(rep(3.14, times = 10)),
    "is_distributed_normally: all values are identical, with value "
  )


})
