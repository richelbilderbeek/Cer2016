context("set_posterior")

test_that("set_posterior: abuse", {

  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = -314, ai = 1, pi = 1,
      posterior = ape::rcoal(10)
    ),
    "sti must be at least 1"
  )

  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 314, ai = 1, pi = 1,
      posterior = ape::rcoal(10)
    ),
    "sti must at most be 2"
  )

  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = -314, pi = 1,
      posterior = ape::rcoal(10)
    ),
    "ai must be at least 1"
  )
  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 314, pi = 1,
      posterior = ape::rcoal(10)
    ),
    "ai must at most be napst"
  )
  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 1, pi = -314,
      posterior = ape::rcoal(10)
    ),
    "pi must be at least 1"
  )
  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 1, pi = 314,
      posterior = ape::rcoal(10)
    ),
    "pi must at most be nppa"
  )
  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 1, pi = 1,
      posterior = "not a posterior"
    ),
    "posterior must be a posterior"
  )

})
