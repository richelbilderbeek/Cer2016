context("is_valid_file")

test_that("is_valid_file: use", {
  filename <- find_path("toy_example_1.RDa")
  expect_true(file.exists(filename))
  expect_true(is_valid_file(filename))
})

test_that("is_valid_file: abuse", {
  expect_error(
    is_valid_file(filename = "inva.lid", verbose = "TRUE nor FALSE"),
    "is_valid_file: verbose should be TRUE or FALSE"
  )

  expect_message(
    is_valid_file(filename = "inva.lid", verbose = TRUE),
    "is_valid_file: file 'inva.lid' not found"
  )
  # Rest is a lot of work to check

  filename <- "test-is_valid_file.RDa"
  saveRDS("I am not a list", file = filename)
  expect_message(
    is_valid_file(filename = filename, verbose = TRUE),
    "is_valid_file: file must be a list\n"
  )
  df <- list()
  saveRDS(df, file = filename)
  expect_message(
    is_valid_file(filename = filename, verbose = TRUE),
    "is_valid_file: file\\$parameters absent" # regex
  )
  df$parameters <- list()
  saveRDS(df, file = filename)
  expect_message(
    is_valid_file(filename = filename, verbose = TRUE),
    "is_valid_file: file\\$pbd_output absent\n"
  )
  df$pbd_output <- list()
  saveRDS(df, file = filename)
  expect_message(
    is_valid_file(filename = filename, verbose = TRUE),
    "is_valid_file: file\\$species_trees absent\n"
  )
  df$species_trees <- list()
  saveRDS(df, file = filename)
  expect_message(
    is_valid_file(filename = filename, verbose = TRUE),
    "is_valid_file: file\\$alignments absent\n"
  )
  df$alignments <- list()
  saveRDS(df, file = filename)
  expect_message(
    is_valid_file(filename = filename, verbose = TRUE),
    "is_valid_file: file\\$posteriors absent\n"
  )
  df$posteriors <- list()
  saveRDS(df, file = filename)

  # Should become: expect_message, no idea why this fails yet
  expect_error(
    is_valid_file(filename = filename, verbose = TRUE),
    "extract_erg: file\\$parameters not found"
  )

  file.remove(filename)
})
