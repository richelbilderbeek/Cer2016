context("set_posterior_by_index")

test_that("set_posterior_by_index: use", {
  file <- read_file(find_path("toy_example_1.RDa"))
  posterior <- get_posterior_by_index(file = file, i = 1)
  expect_true(is_trees_posterior(posterior))
  posterior_new <- parse_beast_trees(
    file = find_path(filename = "beast2_example_output.trees")
  )
  expect_true(is_trees_posterior(posterior_new))
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
