context("calc_act")

test_that("calc_act: abuse", {

  expect_error(
    calc_act(trace = "not numeric", sample_interval = 1),
    "calc_act: trace must be numeric"
  )

  expect_error(
    calc_act(trace = seq(1, 10), sample_interval = 0),
    "calc_act: sample interval must be at least one"
  )

})
