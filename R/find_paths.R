#' Find the path of the BEAST2 binary file
#' @return the path of the BEAST2 binary file
#' @export
find_beast_bin_path <- function() {
  filenames <- c(
    "beast",
    "/home/richel/Programs/beast/bin/beast",                                    # nolint
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
#' @export
find_beast_jar_path <- function() {
  filenames <- c(
    "beast.jar",
    "/home/richel/Programs/beast/lib/beast.jar",                                # nolint
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


#' Find the path of known-to-be-valid BEAST2 posterior file
#' @return the path of a known-to-be-valid BEAST2 posterior file
#' @export
find_beast_posterior_test_filename <- function() {

  filenames <- c(
    "/home/richel/GitHubs/Cer2016/inst/extdata/is_beast_posterior.trees",       # nolint
    "/home/travis/build/richelbilderbeek/Cer2016/inst/extdata/is_beast_posterior.trees",  # nolint
    "is_beast_posterior.trees"
  )
  for (filename in filenames) {
    if (file.exists(filename)) {
      return(filename)
    }
  }
  stop(
    "find_beast_posterior_test_filename: ",
    "cannot find the 'is_beast_posterior.trees' file"
  )
}