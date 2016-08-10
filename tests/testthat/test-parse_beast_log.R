context("parse_beast_log")

test_that("parse_beast_log: use", {

  estimates <- parse_beast_log(
    find_path("beast2_example_output.log")
  )
  expected_names <- c(
   "Sample", "posterior", "likelihood",
   "prior", "treeLikelihood", "TreeHeight",
   "BirthDeath", "birthRate2", "relativeDeathRate2"
  )
  expect_equal(names(estimates), expected_names)

})

test_that("parse_beast_log: abuse", {

  expect_error(
    parse_beast_log(filename = "inva.lid"),
    "file absent"
  )

})
