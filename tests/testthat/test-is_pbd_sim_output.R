context("is_pbd_sim_output")

test_that("basic tests", {
  expect_equal(
    is_pbd_sim_output(PBD::pbd_sim(c(0.2,1,0.2,0.1,0.1),15)),
    TRUE
  )
  expect_equal(
    is_pbd_sim_output(rep(x = 0, times = 9)),
    FALSE
  )
  expect_equal(
    is_pbd_sim_output(as.list(rep(x = 0, times = 9))),
    FALSE
  )
})
