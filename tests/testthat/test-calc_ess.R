context("calc_ess")

test_that("calc_ess: use", {
  estimates <- parse_beast_log(
    filename = find_path("beast2_example_output.log")
  )
  esses <- rep(NA, ncol(estimates))
  burn_in <- 0.1
  for (i in seq_along(estimates)) {
    # Estimates WithOut Burn-in
    ewob <- as.numeric(t(estimates[i]))

    n <- length(ewob)
    first_index <- as.integer(1 + (n * burn_in))
    testit::assert(first_index >= 2)
    # Estimates With Burn-in
    ewb <- ewob[ seq(first_index, n) ]
    testit::assert(length(ewb) < length(ewob))
    esses[i] <- calc_ess(ewb, sampleInterval = 1000)
  }
  expected_esses <- c(3, 10, 10, 10, 10, 7, 10, 9, 6)
  expect_true(all(expected_esses - esses < 0.5))
})
