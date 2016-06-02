context("find_path")

test_that("find_path: basic test", {
  path <- find_path("toy_example_1.RDa")
  expect_equal(file.exists(path), TRUE)
})

test_that("find_path: error on absent file", {
  expect_error(
    find_path("inva.lid"),
    "find_path: cannot find 'inva.lid'"
  )
})

test_that("find_beast_jar_path: basic test", {
  path <- find_beast_jar_path()
  expect_equal(file.exists(path), TRUE)
})
