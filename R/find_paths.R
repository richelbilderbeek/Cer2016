  #' Finds the full path of a file
#' @param filename the name of a file
#' @return the full path of the filename if an existing file could be found, stops otherwise
#' @examples
#'   path <- find_path("toy_example_1.RDa")
#'   testit::assert(file.exists(path))
#' @author Richel Bilderbeek
#' @export
find_path <- function(filename) {

  full_path <- system.file(
    "extdata", filename, package = "Cer2016"
  )

  if (file.exists(full_path)) {
    return(full_path)
  }

  stop(
    "find_path: ",
    "cannot find '", filename, "'"
  )
}


#' Finds the full path of files
#' @param filenames the names of files
#' @return the full path of the filenames if an existing file could be found, stops otherwise
#' @examples
#'   filenames <- Cer2016::find_paths(c("toy_example_1.RDa", "toy_example_2.RDa"))
#'   testit::assert(file.exists(filenames[1]))
#'   testit::assert(file.exists(filenames[2]))
#' @author Richel Bilderbeek
#' @export
find_paths <- function(filenames) {
  filenames <- as.vector(
    vapply(
      filenames,
      Cer2016::find_path,
      FUN.VALUE = "string"
    )
  )
  filenames
}

#' Find the path of the BEAST2 jar file
#' @return the path of the BEAST2 jar file
#' @export
find_beast_jar_path <- function() {
  filenames <- c(
    "beast.jar",
    "/home/richel/Programs/beast/lib/beast.jar",                                # nolint
    "/home/p230198/Programs/beast/lib/beast.jar",                               # nolint
    "/home/travis/build/richelbilderbeek/Programs/beast/lib/beast.jar",         # nolint
    "./Programs/beast/lib/beast.jar",                                           # nolint
    "~/Programs/beast/lib/beast.jar",                                           # nolint
    "./.beast/2.4/BEAST/lib/beast.jar",                                         # nolint
    "E:/Git/BEAST.v2.4.0.Windows/BEAST/lib/beast.jar",                          # nolint
    "C:/Users/Aline/BEAST/lib/beast.jar"                                        # nolint
  )
  for (filename in filenames) {
    if (file.exists(filename)) {
      return(filename)
    }
  }
  stop(
    "find_beast_jar_path: ",
    "cannot find the 'beast.jar' file"
  )
}
