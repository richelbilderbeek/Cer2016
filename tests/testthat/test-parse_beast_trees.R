context("parse_beast_trees")

test_that("parse_beast_trees: use", {
  posterior <- parse_beast_trees(
    find_path("beast2_example_output.trees")
  )
  expect_true(is_trees_posterior(posterior))
})

test_that("parse_beast_trees: abuse", {

  expect_error(
    parse_beast_trees(filename = "inva.lid"),
    "file absent"
  )

  # To be fixed, see
  # https://github.com/richelbilderbeek/Cer2016/issues/118
  if (1 == 2) {
    expect_error(
      parse_beast_trees(
        filename = find_path("toy_example_1.RDa")
      ),
      "argument of length 0"
    )
  }

})
