context("is_beast_posterior")

test_that("can find is_beast_posterior_test.R", {
  filename <- find_path(filename = "is_beast_posterior.trees")
  file_exists <- file.exists(filename)
  expect_true(file_exists)
})

test_that("can create a posterior", {
  filename <- find_path(filename = "is_beast_posterior.trees")
  posterior <- rBEAST::beast2out.read.trees(
    filename
  )
  expect_true(is_beast_posterior(posterior))
})

test_that("can create a posterior with length 10", {
  filename <- find_path(filename = "is_beast_posterior.trees")
  posterior <- rBEAST::beast2out.read.trees(
    filename
  )
  expect_equal(length(posterior), 10)
})

test_that("can detect an invalid posterior, basic types", {
  expect_true(!is_beast_posterior(42))
  expect_true(!is_beast_posterior(3.14))
  expect_true(!is_beast_posterior("Hello world"))
  expect_true(!is_beast_posterior(ape::rcoal(n = 2)))
})

test_that("can detect an invalid posterior, vector", {
  # Putting posteriors in a vector must yield an invalid BEAST posterior
  filename <- find_path(filename = "is_beast_posterior.trees")
  posterior <- rBEAST::beast2out.read.trees(
    filename
  )
  not_posteriors <- c(posterior, posterior)
  expect_equal(length(not_posteriors), 20)
  expect_false(is_beast_posterior(not_posteriors))
})


test_that("can detect an invalid posterior, list", {
  # Putting posteriors in a list must yield an invalid BEAST posterior
  filename <- find_path(filename = "is_beast_posterior.trees")
  posterior <- rBEAST::beast2out.read.trees(
    filename
  )
  not_posteriors <- c(list(posterior), list(posterior))
  expect_equal(length(not_posteriors), 2)
  expect_true(!is_beast_posterior(not_posteriors))
})
