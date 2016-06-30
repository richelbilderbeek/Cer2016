context("plot_posterior_nltts")

test_that("plot_posterior_nltts: use", {

  plot_posterior_nltts(filename = find_path("toy_example_1.RDa"))

})

test_that("plot_posterior_nltts: abuse", {
  expect_error(
    plot_posterior_nltts(filename = "inva.lid"),
    "plot_posterior_nltts: invalid filename"
  )
})
