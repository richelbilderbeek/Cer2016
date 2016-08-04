context("calc_ess")

test_that("calc_ess: use", {

  estimates <- parse_beast_log(
    filename = find_path("beast2_example_output.log")
  )
  esses <- rep(NA, ncol(estimates))
  burn_in <- 0.1
  for (i in seq_along(estimates)) {
    # Trace with the burn-in still present
    trace_raw <- as.numeric(t(estimates[i]))

    # Trace with the burn-in removed
    trace <- remove_burn_in(trace = trace_raw, burn_in = 0.1)

    # Store the effectice sample size
    esses[i] <- calc_ess(trace, sample_interval = 1000)
  }

  # Note that the first value of three is nonsense:
  # it is the index of the sample. I keep it in
  # for simplicity of writing this code
  expected_esses <- c(3, 10, 10, 10, 10, 7, 10, 9, 6)
  expect_true(all(expected_esses - esses < 0.5))
})
