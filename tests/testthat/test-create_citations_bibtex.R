context("create_citations_bibtex")

test_that("create_citations_bibtex works", {
  text <- create_citations_bibtex()
  expect_true(length(text) > 0)
})
