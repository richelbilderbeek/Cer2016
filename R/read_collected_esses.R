#' Read all the collected ESSes of all simulations' posteriors
#' @return a dataframe
#' @examples
#'   df <- read_collected_esses()
#'   expected_names <- c("filename", "sti", "ai", "pi", "min_ess")
#'   testit::assert(names(df) == expected_names)
#'   testit::assert(is.factor(df$filename))
#'   testit::assert(is.factor(df$sti))
#'   testit::assert(is.factor(df$ai))
#'   testit::assert(is.factor(df$pi))
#' @author Richel Bilderbeek
#' @export
read_collected_esses <- function() {
  filename <- Cer2016::find_path("collected_esses.csv")
  testit::assert(file.exists(filename))
  df <- utils::read.csv(
    file = filename,
    header = TRUE,
    stringsAsFactors = FALSE,
    row.names = 1
  )
  df
  df$filename <- as.factor(df$filename)
  df$sti <- as.factor(df$sti)
  df$ai <- as.factor(df$ai)
  df$pi <- as.factor(df$pi)
  testit::assert(names(df) == c(
    "filename", "sti", "ai", "pi", "min_ess"
    )
  )
  testit::assert(is.factor(df$filename))
  testit::assert(is.factor(df$sti))
  testit::assert(is.factor(df$ai))
  testit::assert(is.factor(df$pi))

  df
}
