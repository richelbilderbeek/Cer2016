context("show_parameter_files")

test_that("parameter files are shown", {
  show_parameter_files(
    c(
      find_path("toy_example_1.RDa"),
      find_path("toy_example_2.RDa"),
      find_path("toy_example_3.RDa"),
      find_path("toy_example_4.RDa")
    )
  )
})
