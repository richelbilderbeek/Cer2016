context("remove_burn_in")

test_that("remove_burn_in: use", {

  v <- seq(1, 10)
  w <- remove_burn_in(trace = v, burn_in = 0.1)
  expect_true(w == seq(2, 10))

})

