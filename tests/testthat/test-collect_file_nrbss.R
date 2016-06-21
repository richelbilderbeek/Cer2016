context("collect_file_nrbss")

test_that("collect_file_nrbss: use", {
  filename <- find_path("toy_example_3.RDa")
  file <- read_file(filename)
  names(file)
  length(file$species_trees_with_outgroup)

  length(file$posterior)
  length(file$posterior[[1]])
  length(file$posterior[[1]][[1]])

  class(file$species_trees_with_outgroup[[1]][[1]])
  class(file$species_trees_with_outgroup[[2]][[1]])
  class(file$posterior[[1]][[1]][[1]])
  df <- collect_file_nrbss(filename)
  df
  testit::assert(nrow(df) > 2)

})
