context("calc_esses")

test_that("calc_esses: use", {

  estimates_raw <- parse_beast_log(
    filename = find_path("beast2_example_output.log")
  )

  # Remove burn-in
  estimates <- remove_burn_ins(estimates_raw)

  df <- calc_esses(estimates, sample_interval = 1000)

  df_expected <- estimates[1, ]
  df_expected[1,] <- c(3, 10, 10, 10, 10, 7, 10, 9, 6)


  expect_true(df == df_expected)
})

test_that("calc_esses: abuse", {

  expect_error(
    calc_esses(trace = "not numeric", sample_interval = 1),
    "calc_esses: trace must be a data.frame"
  )

  expect_error(
    calc_esses(trace = seq(1, 10), sample_interval = 0),
    "calc_esses: sample interval must be at least one"
  )

})
