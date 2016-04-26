context("style")

test_that("Use default coding style", {
  # Only check on Travis
  if (substr(getwd(), 1, 13) == "/home/travis/") {
    lintr::expect_lint_free()
  } else {
    skip("Only lint on Travis")
  }
})
