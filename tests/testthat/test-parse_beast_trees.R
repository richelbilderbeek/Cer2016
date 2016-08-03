context("parse_beast_trees")

test_that("parse_beast_trees: use", {
  posterior <- parse_beast_trees(
    find_path("beast2_example_output.trees")
  )
  expect_true(is_posterior(posterior))
})

test_that("parse_beast_trees: abuse", {

  expect_error(
    parse_beast_trees(filename = "inva.lid"),
    "parse_beast_trees: file absent"
  )

})
