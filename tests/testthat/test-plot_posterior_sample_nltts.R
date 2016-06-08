context("plot_posterior_sample_nltts")

test_that("plot_posterior_sample_nltts works", {
  skip("First recreate toy examples")
  plot_posterior_sample_nltts(filename = find_path("toy_example_1.RDa"))
  expect_error(
    plot_posterior_sample_nltts(filename = "inva.lid"),
    "plot_posterior_sample_nltts: invalid filename"
  )

})
