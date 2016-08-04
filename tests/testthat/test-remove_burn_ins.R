context("remove_burn_ins")

test_that("remove_burn_ins: use", {

  # Remove first ten percent
  v <- data.frame(x = seq(1, 10), y = seq(11, 20))
  w <- remove_burn_ins(trace = v, burn_in = 0.1)
  expect_equal(w, seq(2, 10))

  # Remove none of a thousand
  v <- seq(1, 1000)
  w <- remove_burn_ins(trace = v, burn_in = 0.0)
  expect_equal(v, w)

  # Remove all a thousand
  v <- seq(1, 1000)
  w <- remove_burn_ins(trace = v, burn_in = 1.0)
  expect_equal(length(w), 0)

})


test_that("remove_burn_ins: abuse", {

  v <- data.frame(x = seq(1, 10), y = seq(11, 20))

  expect_error(
    remove_burn_ins(traces = v, burn_in = -0.1),
    "remove_burn_ins: burn_in must be at least zero"
  )

  expect_error(
    remove_burn_ins(traces = v, burn_in = 1.1),
    "remove_burn_ins: burn_in must be at most one"
  )

  expect_error(
    remove_burn_ins(traces = "not a valid trace", burn_in = 0.1),
    "remove_burn_ins: traces must be a data.frame"
  )

})
