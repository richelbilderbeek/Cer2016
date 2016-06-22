context("are_identical_posteriors")

test_that("are_identical_posteriors: use", {
  filename <- find_path("toy_example_4.RDa")
  file <- read_file(filename)
  posterior_1 <- get_posterior_by_index(file, 1)
  posterior_2 <- get_posterior_by_index(file, 2)
  posterior_3 <- get_posterior_by_index(file, 3)
  posterior_4 <- get_posterior_by_index(file, 4)
  expect_true(is_beast_posterior(posterior_1))
  expect_true(is_beast_posterior(posterior_2))
  expect_true(is_beast_posterior(posterior_3))
  expect_true(is_beast_posterior(posterior_4))

  # All same posteriors are identical
  expect_true(are_identical_posteriors(posterior_1, posterior_1))
  expect_true(are_identical_posteriors(posterior_2, posterior_2))
  expect_true(are_identical_posteriors(posterior_3, posterior_3))
  expect_true(are_identical_posteriors(posterior_4, posterior_4))

  # All different posteriors are different
  expect_false(are_identical_posteriors(posterior_1, posterior_2))
  expect_false(are_identical_posteriors(posterior_1, posterior_3))
  expect_false(are_identical_posteriors(posterior_1, posterior_4))
  expect_false(are_identical_posteriors(posterior_2, posterior_3))
  expect_false(are_identical_posteriors(posterior_2, posterior_4))
  expect_false(are_identical_posteriors(posterior_3, posterior_4))

})
