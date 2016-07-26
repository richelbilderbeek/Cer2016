context("find_path")

test_that("find_path: basic test", {
  path <- find_path("toy_example_1.RDa")
  expect_true(file.exists(path))
})

test_that("find_path: error on absent file", {
  expect_error(
    find_path("inva.lid"),
    "find_path: cannot find 'inva.lid'"
  )
})

test_that("find_paths: use", {

  filename1 <- "toy_example_1.RDa"
  filename2 <- "toy_example_2.RDa"
  path1 <- find_path(filename1)
  path2 <- find_path(filename2)
  paths <- find_paths(c(filename1, filename2))
  expect_equal(paths[1], path1)
  expect_equal(paths[2], path2)
})

test_that("find_beast_jar_path: basic test", {
  path <- find_beast_jar_path()
  expect_true(file.exists(path))
})
