context("do_test_simulations")

test_that("do_test_simulations works", {
  # Only do this step on Travis
  if (regexpr("travis", getwd())[1] > 0) {
    expect_silent(
      do_test_simulations()
    )
  }
})
