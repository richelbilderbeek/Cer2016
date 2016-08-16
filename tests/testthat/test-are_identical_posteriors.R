context("are_identical_posteriors")

test_that("are_identical_posteriors: use", {

  file <- read_file(find_path("toy_example_1.RDa"))
  posterior_1 <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  posterior_2 <- get_posterior(file = file, sti = 2, ai = 1, pi = 1)
  expect_true(RBeast::is_posterior(posterior_1))
  expect_true(RBeast::is_posterior(posterior_2))
  expect_true(are_identical_posteriors(posterior_1, posterior_1))
  expect_false(are_identical_posteriors(posterior_1, posterior_2))
  expect_false(are_identical_posteriors(posterior_2, posterior_1))
  expect_true(are_identical_posteriors(posterior_2, posterior_2))

})

test_that("are_identical_posteriors: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  posterior_1 <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
  posterior_2 <- get_posterior(file = file, sti = 2, ai = 1, pi = 1)

  expect_error(
    are_identical_posteriors(p = "invalid", q = posterior_2),
    "p must be a Cer2016 posterior"
  )

  expect_error(
    are_identical_posteriors(p = posterior_1, q = "invalid"),
    "q must be a Cer2016 posterior"
  )

})
