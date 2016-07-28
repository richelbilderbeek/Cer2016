context("collect_posterior_gammas")

test_that("collect_posterior_gammas: use", {
  filename <- find_path("toy_example_3.RDa")
  df <- collect_posterior_gammas(filename)
  expect_equal(
    names(df),
    c("species_tree", "alignment", "beast_run", "gamma_stat")
  )
  expect_equal(nrow(df), 80)
})

test_that("collect_posterior_gammas: abuse", {

  expect_error(
    collect_posterior_gammas(filename = "inva.lid"),
    "collect_posterior_gammas: invalid filename"
  )

})
