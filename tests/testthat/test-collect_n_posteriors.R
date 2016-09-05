context("collect_n_posteriors")

test_that("collect_n_posteriors: use case #1", {
  filename <- find_path("toy_example_1.RDa")
  df <- collect_n_posteriors(filename)
  expect_equal(names(df), c("n_posteriors"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
  expect_equal(df$n_posteriors[1], 2)
})

test_that("collect_n_posteriors: use case #2", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_n_posteriors(filename)
  expect_equal(names(df), c("n_posteriors"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
  expect_equal(df$n_posteriors[1], 8)
})

test_that("collect_n_posteriors: empty_file", {
  # An empty file does not have sampled species trees yet
  filename <- "test-collect_n_posteriors.RDa"
  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.1,
    siri = 0.1,
    scr = 0.1,
    erg = 0.1,
    eri = 0.1,
    age = 15,
    mutation_rate = 0.01,
    n_alignments = 2,
    sequence_length = 1000,
    nspp = 10,
    n_beast_runs = 2,
    filename = filename
  )
  df <- collect_n_posteriors(filename)
  expect_equal(names(df), c("n_posteriors"))
  expect_equal(ncol(df), 1)
  expect_equal(nrow(df), 1)
  expect_equal(df$n_posteriors[1], 0)
  file.remove(filename)

})




test_that("collect_n_posteriors: abuse", {
  expect_error(
    collect_n_posteriors(filename = "inva.lid", verbose = "TRUE nor FALSe"), # nolint
    "verbose should be TRUE or FALSE"
  )

  expect_error(
    collect_n_posteriors(filename = "inval.lid"),
    "invalid filename 'inval.lid'"
  )
})
