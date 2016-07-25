context("calc_nltt_stats_from_file")

test_that("calc_nltt_stats_from_file: use", {
  nltt_stats <- calc_nltt_stats_from_file(
    filename = find_path("toy_example_1.RDa")
  )
  expect_equivalent(
    names(nltt_stats),
    c("sti", "ai", "pi", "si", "nltt_stat")
  )
})
