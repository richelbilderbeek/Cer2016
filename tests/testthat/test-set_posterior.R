context("set_posterior_by_index")

test_that("set_posterior_by_index: use", {
  file <- read_file(find_path("toy_example_1.RDa"))
  posterior <- get_posterior_by_index(file = file, i = 1)
  expect_true(is_posterior(posterior))
  posterior_new <- rBEAST::beast2out.read.trees(
    file = find_path(filename = "is_posterior.trees")
  )
  expect_true(is_posterior(posterior_new))
  expect_false(are_identical_posteriors(posterior, posterior_new))
  file <- set_posterior_by_index(
    file = file,
    i = 1,
    posterior = posterior_new
  )
  posterior_new_again <- get_posterior_by_index(file = file, i = 1)
  expect_true(are_identical_posteriors(posterior_new, posterior_new_again))
})


test_that("set_posterior_by_index: abuse", {

  expect_error(
    set_posterior_by_index(
      file = read_file(find_path("toy_example_1.RDa")),
      i = 0,
      posterior = ape::rcoal(10)
    ),
    "set_posterior_by_index: index must be at least 1"
  )

  expect_error(
    set_posterior_by_index(
      file = read_file(find_path("toy_example_1.RDa")),
      i = 3,
      posterior = ape::rcoal(10)
    ),
    "set_posterior_by_index: index must be less than number of posteriors"
  )

})


test_that("set_posterior: abuse", {

  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = -314, ai = 1, pi = 1,
      posterior = ape::rcoal(10)
    ),
    "set_posterior: sti must be at least 1"
  )

  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 314, ai = 1, pi = 1,
      posterior = ape::rcoal(10)
    ),
    "set_posterior: sti must at most be 2"
  )

  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = -314, pi = 1,
      posterior = ape::rcoal(10)
    ),
    "set_posterior: ai must be at least 1"
  )
  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 314, pi = 1,
      posterior = ape::rcoal(10)
    ),
    "set_posterior: ai must at most be napst"
  )
  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 1, pi = -314,
      posterior = ape::rcoal(10)
    ),
    "set_posterior: pi must be at least 1"
  )
  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 1, pi = 314,
      posterior = ape::rcoal(10)
    ),
    "set_posterior: pi must at most be nppa"
  )
  expect_error(
    set_posterior(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 1, pi = 1,
      posterior = "not a posterior"
    ),
    "set_posterior: posterior must be a posterior"
  )


})
