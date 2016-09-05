context("get_alignment_by_index")

test_that("get_alignment_by_index: #1", {
  file <- read_file(find_path("toy_example_1.RDa"))
  i <- 1
  alignment <- get_alignment_by_index(file, i)
  expect_true(is_alignment(alignment))
})

test_that("get_alignment_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  i <- 4
  alignment <- get_alignment_by_index(file, i)
  expect_true(is_alignment(alignment))
  expect_true(
    identical(
      alignment,
      get_alignment_by_index(file, i)
    )
  )
})

test_that("set_alignment_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  alignment_1 <- get_alignment_by_index(file, 1)
  alignment_2 <- get_alignment_by_index(file, 2)
  alignment_3 <- get_alignment_by_index(file, 3)
  alignment_4 <- get_alignment_by_index(file, 4)
  expect_true(is_alignment(alignment_1))
  expect_true(is_alignment(alignment_2))
  expect_true(is_alignment(alignment_3))
  expect_true(is_alignment(alignment_4))

  # All same alignments are identical
  expect_true(identical(alignment_1, alignment_1))
  expect_true(identical(alignment_2, alignment_2))
  expect_true(identical(alignment_3, alignment_3))
  expect_true(identical(alignment_4, alignment_4))

  # All different alignments are different
  expect_false(identical(alignment_1, alignment_2))
  expect_false(identical(alignment_1, alignment_3))
  expect_false(identical(alignment_1, alignment_4))
  expect_false(identical(alignment_2, alignment_3))
  expect_false(identical(alignment_2, alignment_4))
  expect_false(identical(alignment_3, alignment_4))

  # Copy #1 over #2
  file <- set_alignment_by_index(file, 2, alignment_1)
  expect_true(
    identical(
      get_alignment_by_index(file, 1),
      get_alignment_by_index(file, 2)
    )
  )

  # Copy #3 over #4
  file <- set_alignment_by_index(file, 4, alignment_3)
  expect_true(
    identical(
      get_alignment_by_index(file, 3),
      get_alignment_by_index(file, 4)
    )
  )

})

test_that("get_alignment_by_index from fresh file", {
  filename <- "test-get_alignment_by_index.RDa"

  # Pre clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  n_alignments <- 1 # So two in total

  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = n_alignments,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename
  )

  file <- read_file(filename = filename)

  # No alignment yet
  expect_error(
    get_alignment_by_index(file, 1),
    "alignment absent at index 1"
  )
  expect_error(
    get_alignment_by_index(file, 2),
    "alignment absent at index 2"
  )

  # Getting a alignment
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny <- ape::rcoal(n = 5),
    sequence_length = 10
  )
  other_alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny <- ape::rcoal(n = 5),
    sequence_length = 10
  )

  expect_true(is_alignment(alignment))

  file <- set_alignment_by_index(
    file = file,
    i = 2,
    alignment = alignment
  )

  alignment_again <- get_alignment_by_index(
    file = file,
    i = 2
  )

  expect_true(identical(alignment, alignment_again))
  expect_false(identical(alignment, other_alignment))

  file.remove(filename)
})


test_that("get_alignment_by_index: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))

  expect_error(
    get_alignment_by_index(file = file, i = -314),
    "index must be at least 1"
  )

  expect_error(
    get_alignment_by_index(file = file, i = 42),
    "index must be less than number of alignments"
  )

  file <- set_alignment_by_index(file = file, i = 1, alignment = NA)
  expect_error(
    get_alignment_by_index(file = file, i = 1),
    "alignment absent at index 1"
  )

})
