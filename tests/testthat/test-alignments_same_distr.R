context("alignments_same_distr")

test_that("dataset is too small sometimes", {
  # Collect the nLTT stats
  nltt_stats_raw <- read_collected_nltt_stats()
  # Remove the NAs
  nltt_stats <- nltt_stats_raw[!is.na(nltt_stats_raw$nltt_stat), ]
  df <- alignments_same_distr_nltt_stat(nltt_stats)
  t <- dplyr::count(df, same_distr)


  # There will be some NA's, but also some TRUEs and FALSEs
  expect_true(nrow(t) > 1)
})

test_that(paste("create artifical dataset:",
  "cannot compare if there is only one alignment"), {

  # Create a fake dataset with 100 nLTT statistics per BEAST2 posterior
  # resulting in 200 rows in totla
  set.seed(42)
  nltt_stats <- data.frame(
    filename = rep("fake.RDa", 200),
    sti = rep(1, 200),
    ai = rep(1, 200),
    pi = rep(c(1, 2), each = 100),
    si = rep(1:100, 2),
    nltt_stat = c(runif(100), runif(100))
  )
  expect_error(
    alignments_same_distr_nltt_stat(nltt_stats),
    "Cannot compare alignments if there is only one"
  )
})

test_that(paste("create artifical dataset:",
  "compare two identical alignments"), {

  # Create a fake dataset with 100 nLTT statistics per BEAST2 posterior
  # resulting in 200 rows in total
  set.seed(314)
  nltt_stats <- data.frame(
    filename = rep("fake.RDa", 200),
    sti = rep(c(1,2), each = 100, times = 1),
    ai = rep(c(1, 2), each = 50, times = 2),
    pi = rep(c(1, 2), each = 25, times = 4),
    si = rep(1:25, 4),
    nltt_stat = runif(200)
  )
  df <- alignments_same_distr_nltt_stat(nltt_stats)
  t <- dplyr::count(df, same_distr)
  expect_true(t$same_distr[1] == TRUE)
  expect_true(t$n[1] == 2)

})

test_that(paste("create artifical dataset:",
  "compare two different distributions"), {

  # Create a fake dataset with 100 nLTT statistics per BEAST2 posterior
  # resulting in 200 rows in totla
  nltt_stats <- data.frame(
    filename = rep("fake.RDa", 200),
    sti = rep(1, 200),
    ai = rep(c(1, 2), each = 100),
    pi = rep(c(1, 2), times = 2, each = 50),
    si = rep(1:50, 4),
    nltt_stat = c(runif(100), rnorm(100))
  )
  df <- alignments_same_distr_nltt_stat(nltt_stats)
  t <- dplyr::count(df, same_distr)
  expect_true(t$same_distr[1] == FALSE)
  expect_true(t$n[1] == 1)
})
