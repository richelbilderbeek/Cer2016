context("plot_posterior_nltts")

test_that("plot_posterior_nltts works", {
  skip("First recreate toy examples")

  plot_posterior_nltts(filename = find_path("toy_example_1.RDa"))
  expect_error(
    plot_posterior_nltts(filename = "inva.lid"),
    "plot_posterior_nltts: invalid filename"
  )
})
