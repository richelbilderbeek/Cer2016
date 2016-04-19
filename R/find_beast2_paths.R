#' Find the path of the BEAST2 binary file
#' @return the path of the BEAST2 binary file
#' @examples
#'   my_file <- find_beast2_bin_path()
#'   does_exist <- file.exists(my_file)
#'   testit::assert(does_exist)
#' @export
find_beast_bin_path <- function() {
  filenames <- c(
    "beast",
    "~/Programs/beast/bin/beast",                                               # nolint
    "/home/travis/build/richelbilderbeek/Programs/beast/bin/beast"              # nolint
  )
  for (filename in filenames) {
    if (file.exists(filename)) {
      return(filename)
    }
  }
  stop(
    "get_input_fasta_filename: ",
    "cannot find the 'test_output_0.fas' file"
  )
}

#' Find the path of the BEAST2 jar file
#' @return the path of the BEAST2 jar file
#' @examples
#'   my_file <- find_beast2_jar_path()
#'   does_exist <- file.exists(my_file)
#'   testit::assert(does_exist)
#' @export
find_beast_jar_path <- function() {
  filenames <- c(
    "beast.jar",
    "~/Programs/beast/lib/beast.jar",                                           # nolint
    "/home/travis/build/richelbilderbeek/Programs/beast/lib/beast.jar"          # nolint
  )
  for (filename in filenames) {
    if (file.exists(filename)) {
      return(filename)
    }
  }
  stop(
    "get_output_xml_filename: ",
    "cannot find the 'birth_death_0_20151005.xml' file"
  )
}
