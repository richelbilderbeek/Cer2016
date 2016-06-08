context("plot_posterior_samples")

test_that("plot_posterior_samples works", {
  skip("First recreate toy examples")

  plot_posterior_samples(filename = find_path("toy_example_1.RDa"))
  expect_error(
    plot_posterior_samples(filename = "inva.lid"),
    "plot_posterior_samples: invalid filename"
  )
  expect_equal(file.exists("Rplots.pdf", FALSE))
})
