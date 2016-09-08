context("are_beast_replicates_from_same_distribution")

test_that("dataset is too small sometimes", {
  # Collect the nLTT stats
  nltt_stats_raw <- read_collected_nltt_stats()
  # Remove the NAs
  nltt_stats <- nltt_stats_raw[!is.na(nltt_stats_raw$nltt_stat), ]
  df <- are_beast_replicates_from_same_distribution(nltt_stats)
  t <- dplyr::count(df, same_distr)

  # There will be some NA's, but also some TRUEs and FALSEs
  expect_true(is.na(t$same_distr[3]))
  expect_true(t$n[3] > 1)
})

test_that("create artifical dataset: same distributions", {

  # Create a fake dataset with 100 nLTT statistics per BEAST2 posterior
  # resulting in 200 rows in totla
  nltt_stats <- data.frame(
    filename = rep("fake.RDa", 200),
    sti = rep(1, 200),
    ai = rep(1, 200),
    pi = rep(c(1,2), each = 100),
    si = rep(1:100, 2),
    nltt_stat = c(runif(100), runif(100))
  )
  df <- are_beast_replicates_from_same_distribution(nltt_stats)
  t <- dplyr::count(df, same_distr)
  expect_true(t$same_distr[1] == TRUE)
  expect_true(t$n[1] == 1)
})

test_that("create artifical dataset: different distributions", {

  # Create a fake dataset with 100 nLTT statistics per BEAST2 posterior
  # resulting in 200 rows in totla
  nltt_stats <- data.frame(
    filename = rep("fake.RDa", 200),
    sti = rep(1, 200),
    ai = rep(1, 200),
    pi = rep(c(1,2), each = 100),
    si = rep(1:100, 2),
    nltt_stat = c(runif(100), rnorm(100))
  )
  df <- are_beast_replicates_from_same_distribution(nltt_stats)
  t <- dplyr::count(df, same_distr)
  expect_true(t$same_distr[1] == FALSE)
  expect_true(t$n[1] == 1)
})
