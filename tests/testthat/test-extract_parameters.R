context("extract_parameters")

test_that("extract_erg", {
  file <- read_file(find_path("toy_example_1.RDa"))
  erg <- extract_erg(file)
  expect_true(erg >= 0.0)
})

test_that("extract_eri", {
  file <- read_file(find_path("toy_example_1.RDa"))
  eri <- extract_eri(file)
  expect_true(eri >= 0.0)
})

test_that("extract_scr", {
  file <- read_file(find_path("toy_example_1.RDa"))
  scr <- extract_scr(file)
  expect_true(scr >= 0.0)
})


test_that("extract_sirg", {
  file <- read_file(find_path("toy_example_1.RDa"))
  expect_equal("sirg" %in% names(file$parameters), TRUE)
  expect_equal(
    "species_initiation_rate_good_species" %in% names(file$parameters),
    FALSE
  )
  sirg <- extract_sirg(file)
  expect_true(sirg >= 0.0)
})

test_that("extract_siri", {
  file <- read_file(find_path("toy_example_1.RDa"))
  siri <- extract_siri(file)
  expect_true(siri >= 0.0)
})
