#' Finds the full pathof a file
#' @param filename the name of a file
#' @return the full path of the filename if an existing file could be found, stops otherwise
#' @export
find_path <- function(filename) {
  if (file.exists(filename)) {
    return(filename)
  }

  prefixes <- c(
    "/home/richel/GitHubs/Cer2016/inst/extdata/",       # nolint
    "/home/p230198/GitHubs/Cer2016/inst/extdata/",       # nolint
    "/home/travis/build/richelbilderbeek/Cer2016/inst/extdata/"  # nolint
  )
  for (prefix in prefixes) {
    full_path <- paste(prefix, filename, sep = "")
    if (file.exists(full_path)) {
      return(full_path)
    }
  }
  stop(
    "find_path: ",
    "cannot find '", filename, "'"
  )

}

#' Find the path of the BEAST2 binary file
#' @return the path of the BEAST2 binary file
#' @export
find_beast_bin_path <- function() {
  filenames <- c(
    "beast",
    "/home/richel/Programs/beast/bin/beast",                                    # nolint
    "/home/p230198/Programs/beast/bin/beast",                                    # nolint
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
    "/home/p230198/Programs/beast/lib/beast.jar",                               # nolint
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
  return(find_path("is_beast_posterior.trees"))
}