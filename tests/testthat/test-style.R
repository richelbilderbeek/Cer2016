context("style")

test_that("Use default coding style", {
  lintr::expect_lint_free()
})
