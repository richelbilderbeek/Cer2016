context("read_collected_nltts_postrs")

test_that("read_collected_nltts_postrs: use", {
  df <- read_collected_nltts_postrs()
  testit::assert(names(df) ==
    c(
      "filename", "species_tree", "alignment",
      "beast_run", "state", "t", "nltt"
    )
  )
})
