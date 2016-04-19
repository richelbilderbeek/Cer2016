#' Function that shows how much parameter files are present,
#' and how far the pipeline has gotten
#' @param folder The folder containing the parameter files
#' @return A data table showing the progress
#' @export
#' @author Richel Bilderbeek
check_progress <- function(
  folder = "~/Slurm/"                                                           # nolint
) {
  files <- list.files(path = folder, pattern = ".RDa")
  df <- data.frame(
    files = files,
    progress = rep("0 %", length(files))
  )
  df
}