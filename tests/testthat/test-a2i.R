context("a2i")

test_that("a2i: only index must be one", {

  expect_equal(1, a2i(sti = 1, ai = 1, nstpist = 1, napst = 1))
})

test_that("a2i: only two species tree indices must be one and two", {

  expect_equal(1, a2i(sti = 1, ai = 1, nstpist = 1, napst = 1))
  expect_equal(2, a2i(sti = 2, ai = 1, nstpist = 2, napst = 1))
})

test_that("a2i: only two alignment indices must be one and two", {

  expect_equal(1, a2i(sti = 1, ai = 1, nstpist = 1, napst = 1))
  expect_equal(2, a2i(sti = 1, ai = 2, nstpist = 1, napst = 2))
})

test_that("a2i: only three species tree indices must be one to three", {

  expect_equal(1, a2i(sti = 1, ai = 1, nstpist = 1, napst = 1))
  expect_equal(2, a2i(sti = 2, ai = 1, nstpist = 2, napst = 1))
  expect_equal(3, a2i(sti = 3, ai = 1, nstpist = 3, napst = 1))
})

test_that("a2i: only three alignment indices must be one to three", {

  expect_equal(1, a2i(sti = 1, ai = 1, nstpist = 1, napst = 3))
  expect_equal(2, a2i(sti = 1, ai = 2, nstpist = 1, napst = 3))
  expect_equal(3, a2i(sti = 1, ai = 3, nstpist = 1, napst = 3))
})
