#' Read all the collected nLTT statistics of all simulations
#' @return a dataframe
#' @examples
#'   df <- read_collected_nltt_stats()
#'   expected_names <- c("filename", "sti", "ai", "pi", "si", "nltt_stat")
#'   testit::assert(names(df) == expected_names)
#'   testit::assert(is.factor(df$filename))
#'   testit::assert(is.factor(df$sti))
#'   testit::assert(is.factor(df$ai))
#'   testit::assert(is.factor(df$pi))
#'   testit::assert(is.factor(df$si))
#' @author Richel Bilderbeek
#' @export
read_collected_nltt_stats <- function() {
  filename <- Cer2016::find_path("collected_nltt_stats.csv")
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
  df$si <- as.factor(df$si)
  testit::assert(names(df) == c(
    "filename", "sti", "ai", "pi", "si", "nltt_stat"
    )
  )
  testit::assert(is.factor(df$filename))
  testit::assert(is.factor(df$sti))
  testit::assert(is.factor(df$ai))
  testit::assert(is.factor(df$pi))
  testit::assert(is.factor(df$si))

  df
}
