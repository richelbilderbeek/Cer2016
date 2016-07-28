context("set_alignment")

test_that("set_alignment: abuse", {

  expect_error(
    set_alignment(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = -314, ai = 1,
      alignment = ape::rcoal(10)
    ),
    "set_alignment: sti must be at least 1"
  )

  expect_error(
    set_alignment(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 314, ai = 1,
      alignment = ape::rcoal(10)
    ),
    "set_alignment: sti must at most be 2"
  )

  expect_error(
    set_alignment(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = -314,
      alignment = ape::rcoal(10)
    ),
    "set_alignment: ai must be at least 1"
  )
  expect_error(
    set_alignment(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 314,
      alignment = ape::rcoal(10)
    ),
    "set_alignment: ai must at most be napst"
  )
  expect_error(
    set_alignment(
      file = read_file(find_path("toy_example_1.RDa")),
      sti = 1, ai = 1,
      alignment = "not a alignment"
    ),
    "set_alignment: alignment must be an alignment"
  )


})
