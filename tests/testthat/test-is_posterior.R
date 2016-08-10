context("is_posterior")

test_that("is_posterior: use", {

  file <- read_file(find_path("toy_example_1.RDa"))
  posterior <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  expect_true(is_posterior(posterior))

  expect_false(is_posterior(x = "invalid"))

  expect_message(
    is_posterior(x = "invalid", verbose = TRUE),
    "x is not a list"
  )
})


test_that("is_posterior: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  posterior <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  expect_error(
    is_posterior(posterior, verbose = "invalid"),
    "verbose should be TRUE or FALSE"
  )

})
