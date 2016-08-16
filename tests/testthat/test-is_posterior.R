context("is_posterior")

test_that("is_posterior: use", {

  file <- read_file(find_path("toy_example_1.RDa"))
  posterior <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  expect_true(RBeast::is_posterior(posterior))
})


test_that("is_posterior: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  posterior <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  expect_error(
    RBeast::is_posterior(posterior, verbose = "invalid"),
    "verbose should be TRUE or FALSE"
  )

})
