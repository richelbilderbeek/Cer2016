context("set_alignment_by_index")

test_that("set_alignment_by_index: use", {
  file <- read_file(find_path("toy_example_1.RDa"))
  alignment <- get_alignment_by_index(file = file, i = 1)
  expect_true(is_alignment(alignment))
  alignment_new <- beastscriptr::create_random_alignment(
    n_taxa = 5,
    sequence_length = 10
  )

  expect_false(are_identical_alignments(alignment, alignment_new))
  file <- set_alignment_by_index(
    file = file,
    i = 1,
    alignment = alignment_new
  )
  alignment_new_again <- get_alignment_by_index(file = file, i = 1)
  expect_true(are_identical_alignments(alignment_new, alignment_new_again))
})


test_that("set_alignment_by_index: abuse", {

  expect_error(
    set_alignment_by_index(
      file = read_file(find_path("toy_example_1.RDa")),
      i = 0,
      alignment = ape::rcoal(10)
    ),
    "index must be at least 1"
  )

  expect_error(
    set_alignment_by_index(
      file = read_file(find_path("toy_example_1.RDa")),
      i = 3,
      alignment = ape::rcoal(10)
    ),
    "index must be less than number of alignments"
  )

})
