context("create_citations_bibtex")

test_that("create_citations_bibtex works", {
  text <- create_citations_bibtex()
  expect_equal(length(text) > 0, TRUE)
})
