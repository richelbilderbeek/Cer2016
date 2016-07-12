context("read_collected_nltts_strees")

test_that("read_collected_nltts_strees: use", {
  df <- read_collected_nltts_strees()
  expect_true(
    identical(
      names(df),
      c("filename", "species_tree", "t", "nltt")
    )
  )
})
