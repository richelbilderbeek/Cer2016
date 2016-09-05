context("extract_parameters")

test_that("extract_erg: use", {

  file <- read_file(find_path("toy_example_1.RDa"))
  erg <- extract_erg(file)
  expect_true(erg >= 0.0)
})

test_that("extract_erg: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_erg(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$erg <- NULL
  expect_error(
    extract_erg(file),
    "parameter 'erg' absent"
  )

})

test_that("extract_eri", {

  file <- read_file(find_path("toy_example_1.RDa"))
  eri <- extract_eri(file)
  expect_true(eri >= 0.0)
})

test_that("extract_eri: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_eri(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$eri <- NULL
  expect_error(
    extract_eri(file),
    "parameter 'eri' absent"
  )

})

test_that("extract_scr", {

  file <- read_file(find_path("toy_example_1.RDa"))
  scr <- extract_scr(file)
  expect_true(scr >= 0.0)
})

test_that("extract_scr: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_scr(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$scr <- NULL
  expect_error(
    extract_scr(file),
    "parameter 'scr' absent"
  )

})

test_that("extract_sirg", {

  file <- read_file(find_path("toy_example_1.RDa"))
  expect_true("sirg" %in% names(file$parameters))
  expect_false(
    "species_initiation_rate_good_species" %in% names(file$parameters)
  )
  sirg <- extract_sirg(file)
  expect_true(sirg >= 0.0)
})

test_that("extract_sirg: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_sirg(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$sirg <- NULL
  expect_error(
    extract_sirg(file),
    "parameter 'sirg' absent"
  )

})

test_that("extract_siri", {

  file <- read_file(find_path("toy_example_1.RDa"))
  siri <- extract_siri(file)
  expect_true(siri >= 0.0)
})

test_that("extract_siri: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_siri(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$siri <- NULL
  expect_error(
    extract_siri(file),
    "parameter 'siri' absent"
  )

})

test_that("extract_napst", {
  file <- read_file(find_path("toy_example_1.RDa"))
  napst <- extract_napst(file)
  expect_equal(napst, 1)
})

test_that("extract_napst: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_napst(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$n_alignments <- NULL
  expect_error(
    extract_napst(file),
    "parameter 'n_alignments' absent"
  )

})

test_that("extract_nppa: use", {
  file <- read_file(find_path("toy_example_1.RDa"))
  nppa <- extract_nppa(file)
  expect_equal(nppa, 1)
})

test_that("extract_nppa: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_nppa(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$n_beast_runs <- NULL
  expect_error(
    extract_nppa(file),
    "parameter 'n_beast_runs' absent"
  )

})


test_that("extract_nspp: use", {
  file <- read_file(find_path("toy_example_1.RDa"))
  nspp <- extract_nspp(file)
  expect_equal(nspp, 10)
})


test_that("extract_nspp: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_nspp(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$mcmc_chainlength <- NULL
  file$parameters$nspp <- NULL
  expect_error(
    extract_nspp(file),
    "parameter 'nspp' absent"
  )

})
