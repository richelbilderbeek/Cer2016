context("plot_posterior_samples")

test_that("plot_posterior_samples: use", {

  plot_posterior_samples(filename = find_path("toy_example_1.RDa"))

})


test_that("plot_posterior_samples: abuse", {
  expect_error(
    plot_posterior_samples(filename = "inva.lid"),
    "plot_posterior_samples: invalid filename"
  )
})
