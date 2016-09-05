context("get_alignment")

test_that("get_alignment: #1", {
  file <- read_file(find_path("toy_example_1.RDa"))
  alignment_1 <- get_alignment(file = file, sti = 1, ai = 1)
  alignment_2 <- get_alignment(file = file, sti = 2, ai = 1)
  expect_true(is_alignment(alignment_1))
  expect_true(is_alignment(alignment_2))
})

test_that("get_alignment: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  alignment_1 <- get_alignment(file = file, sti = 1, ai = 1)
  alignment_2 <- get_alignment(file = file, sti = 2, ai = 2)
  alignment_3 <- get_alignment(file = file, sti = 2, ai = 1)
  alignment_4 <- get_alignment(file = file, sti = 2, ai = 2)
  expect_true(is_alignment(alignment_1))
  expect_true(is_alignment(alignment_2))
  expect_true(is_alignment(alignment_3))
  expect_true(is_alignment(alignment_4))
})

test_that("set_alignment_by_index: #4", {
  file <- read_file(find_path("toy_example_4.RDa"))
  alignment_1 <- get_alignment(file = file, sti = 1, ai = 1)
  alignment_2 <- get_alignment(file = file, sti = 1, ai = 2)
  alignment_3 <- get_alignment(file = file, sti = 2, ai = 1)
  alignment_4 <- get_alignment(file = file, sti = 2, ai = 2)
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
  # Condition to change:
  expect_false(identical(alignment_1, alignment_2))

  # Do it
  file <- set_alignment(file, sti = 1, ai = 2, alignment_1)

  # Update
  alignment_1 <- get_alignment(file = file, sti = 1, ai = 1)
  alignment_2 <- get_alignment(file = file, sti = 1, ai = 2)
  alignment_3 <- get_alignment(file = file, sti = 2, ai = 1)
  alignment_4 <- get_alignment(file = file, sti = 2, ai = 2)

  # Condition has changed?
  expect_true(identical(alignment_1, alignment_2))

  # Copy #3 over #4
  # Condition to change:
  expect_false(identical(alignment_3, alignment_4))

  # Do it
  file <- set_alignment(file, sti = 2, ai = 1, alignment_4)

  # Update
  alignment_1 <- get_alignment(file = file, sti = 1, ai = 1)
  alignment_2 <- get_alignment(file = file, sti = 1, ai = 2)
  alignment_3 <- get_alignment(file = file, sti = 2, ai = 1)
  alignment_4 <- get_alignment(file = file, sti = 2, ai = 2)

  # Condition has changed?
  expect_true(identical(alignment_3, alignment_4))
})

test_that("get_alignment from fresh file", {
  filename <- "test-get_alignment.RDa"

  # Pre clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  napst <- 1 # Number of alignments per species tree

  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = napst,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename
  )

  file <- read_file(filename = filename)

  # No alignment yet
  expect_error(
    get_alignment(file, sti = 1, ai = 1),
    "alignment absent at index 1"
  )
  expect_error(
    get_alignment(file, sti = 2, ai = 1),
    "alignment absent at index 2"
  )

  # Getting alignments
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny <- ape::rcoal(n = 5),
    sequence_length = 10
  )
  other_alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny <- ape::rcoal(n = 5),
    sequence_length = 10
  )

  expect_true(is_alignment(alignment))
  expect_true(is_alignment(other_alignment))

  file <- set_alignment(
    file = file,
    sti = 2,
    ai = 1,
    alignment = alignment
  )

  alignment_again <- get_alignment(
    file = file,
    sti = 2,
    ai = 1
  )

  expect_true(identical(alignment, alignment_again))
  expect_false(identical(alignment, other_alignment))

  file.remove(filename)
})


test_that("get_alignment: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))

  expect_error(
    get_alignment(file = file, sti = -314, ai = 1),
    "sti must be at least 1"
  )

  expect_error(
    get_alignment(file = file, sti = 314, ai = 1),
    "sti must at most be 2"
  )

  expect_error(
    get_alignment(file = file, sti = 1, ai = -314),
    "ai must be at least 1"
  )

  expect_error(
    get_alignment(file = file, sti = 1, ai = 314),
    "ai must at most be napst"
  )

})
