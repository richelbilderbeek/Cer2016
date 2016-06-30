context("p2i")

test_that("p2i: only index must be one", {

  expect_equal(1, p2i(sti = 1, ai = 1, pi = 1, nstpist = 1, napst = 1, nppa = 1)) # nolint
})

test_that("p2i: only two species tree indices must be one and two", {

  expect_equal(1, p2i(sti = 1, ai = 1, pi = 1, nstpist = 1, napst = 1, nppa = 1)) # nolint
  expect_equal(2, p2i(sti = 2, ai = 1, pi = 1, nstpist = 2, napst = 1, nppa = 1)) # nolint
})

test_that("p2i: only two alignment indices must be one and two", {

  expect_equal(1, p2i(sti = 1, ai = 1, pi = 1, nstpist = 1, napst = 1, nppa = 1)) # nolint
  expect_equal(2, p2i(sti = 1, ai = 2, pi = 1, nstpist = 1, napst = 2, nppa = 1)) # nolint
})

test_that("p2i: only two posterior indices must be one and two", {

  expect_equal(1, p2i(sti = 1, ai = 1, pi = 1, nstpist = 1, napst = 1, nppa = 2)) # nolint
  expect_equal(2, p2i(sti = 1, ai = 1, pi = 2, nstpist = 1, napst = 1, nppa = 2)) # nolint
})

test_that("p2i: only three species tree indices must be one to three", {

  expect_equal(1, p2i(sti = 1, ai = 1, pi = 1, nstpist = 1, napst = 1, nppa = 1)) # nolint
  expect_equal(2, p2i(sti = 2, ai = 1, pi = 1, nstpist = 2, napst = 1, nppa = 1)) # nolint
  expect_equal(3, p2i(sti = 3, ai = 1, pi = 1, nstpist = 3, napst = 1, nppa = 1)) # nolint
})

test_that("p2i: only three alignment indices must be one to three", {

  expect_equal(1, p2i(sti = 1, ai = 1, pi = 1, nstpist = 1, napst = 3, nppa = 1)) # nolint
  expect_equal(2, p2i(sti = 1, ai = 2, pi = 1, nstpist = 1, napst = 3, nppa = 1)) # nolint
  expect_equal(3, p2i(sti = 1, ai = 3, pi = 1, nstpist = 1, napst = 3, nppa = 1)) # nolint
})

test_that("p2i: only three posterior indices must be one to three", {

  expect_equal(1, p2i(sti = 1, ai = 1, pi = 1, nstpist = 1, napst = 1, nppa = 3)) # nolint
  expect_equal(2, p2i(sti = 1, ai = 1, pi = 2, nstpist = 1, napst = 1, nppa = 3)) # nolint
  expect_equal(3, p2i(sti = 1, ai = 1, pi = 3, nstpist = 1, napst = 1, nppa = 3)) # nolint
})
