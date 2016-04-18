context("is_beast_posterior")

get_is_beast_posterior_test_filename <- function() {
  # Return an existing .trees filename

  filenames <- c(
    "is_beast_posterior.trees",
    "~/GitHubs/Cer2016/tests/testthat/is_beast_posterior.trees"
  )
  for (filename in filenames) {
    if (file.exists(filename)) { return (filename) }
  }
  stop(
    "get_is_beast_posterior_test_filename: ",
    "cannot find the 'is_beast_posterior_test.R' file"
  )
}


test_that("install olli0601 his/her rBEAST package", {
  skip("Not now")
  expect_true(exists('beast2out.read.trees', where='package:rBEAST', mode='function'))
})

test_that("can find is_beast_posterior_test.R", {
  filename <- get_is_beast_posterior_test_filename()
  file_exists <- file.exists(filename)
  expect_equal(file_exists, TRUE)
})


test_that("can create a posterior", {
  posterior <- rBEAST::beast2out.read.trees(get_is_beast_posterior_test_filename())
  expect_equal(is_beast_posterior(posterior), TRUE)
  expect_equal(length(posterior), 10)
})

test_that("can detect an invalid posterior, basic types", {
  expect_true(!is_beast_posterior(42))
  expect_true(!is_beast_posterior(3.14))
  expect_true(!is_beast_posterior("Hello world"))
  expect_true(!is_beast_posterior(rcoal(n = 2)))
})

test_that("can detect an invalid posterior, vector", {
  # Putting posteriors in a vector must yield an invalid BEAST posterior
  posterior <- rBEAST::beast2out.read.trees(get_is_beast_posterior_test_filename())
  not_posteriors <- c(posterior,posterior)
  expect_equal(length(not_posteriors), 20)
  expect_true(!is_beast_posterior(not_posteriors))
})


test_that("can detect an invalid posterior, list", {
  # Putting posteriors in a list must yield an invalid BEAST posterior
  posterior <- rBEAST::beast2out.read.trees(get_is_beast_posterior_test_filename())
  not_posteriors <- c(list(posterior),list(posterior))
  expect_equal(length(not_posteriors), 2)
  expect_true(!is_beast_posterior(not_posteriors))
})

