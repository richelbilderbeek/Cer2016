context("do_test_simulations")

test_that("do_test_simulations: create exact replicate", {

  filenames_1 <- paste0("do_test_simulations_1_", seq(1, 4), ".RDa")
  filenames_2 <- paste0("do_test_simulations_2_", seq(1, 4), ".RDa")

  for (filename in c(filenames_1, filenames_2)) {
    if (file.exists(filename)) {
      file.remove(filename)
    }
  }

  do_test_simulations(filenames = filenames_1)
  do_test_simulations(filenames = filenames_2)

  testit::assert(length(filenames_1) == length(filenames_2))
  i <- 1
  for (i in seq(1, length(filenames_1))) {
    filename_1 <- filenames_1[i]
    filename_2 <- filenames_2[i]
    testit::assert(filename_1 != filename_2)
    testit::assert(file.exists(filename_1))
    testit::assert(file.exists(filename_2))
    sum_1 <- tools::md5sum(filename_1)[[1]]
    sum_2 <- tools::md5sum(filename_2)[[1]]
    expect_equal(sum_1, sum_2)
  }

  file.remove(filenames_1)
  file.remove(filenames_2)

})

test_that("do_test_simulations: abuse", {
  filenames <- paste0("do_test_simulations_", seq(1, 4), ".RDa")

  expect_error(
    do_test_simulations(
      filenames = filenames,
      verbose = "TRUE nor FALSE"
    ),
    "verbose should be TRUE or FALSE"
  )

  expect_error(
    do_test_simulations(
      filenames = c("too", "few")
    ),
    "must have exactly four filenames"
  )
})
