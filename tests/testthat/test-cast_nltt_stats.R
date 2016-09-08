context("cast_nltt_stats")

test_that("cast_nltt_stats: use", {

  # Collect an nLTT stats data frame
  nltt_stats_raw <- read_collected_nltt_stats()
  nltt_stats <- nltt_stats_raw[!is.na(nltt_stats_raw$nltt_stat), ]

  expect_true("si" %in% names(nltt_stats))
  expect_true("nltt_stat" %in% names(nltt_stats))

  df1 <- reshape2::dcast(
      nltt_stats,
      filename + sti + ai + pi ~ si,
      value.var = "nltt_stat"
    )

  df2 <- cast_nltt_stats(nltt_stats)

  expect_true(all.equal(df1, df2))
  expect_true(nrow(df2) < nrow(nltt_stats))
  expect_false("si" %in% names(df2))
  expect_false("nltt_stat" %in% names(df2))

})
