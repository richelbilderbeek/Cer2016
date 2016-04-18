#' Installs the libraries needed
#' @export
install_libraries <- function() {
  install.packages("ape", repos="http://cran.r-project.org")
  install.packages("DDD", repos="http://cran.r-project.org")
  install.packages("plyr", repos="http://cran.r-project.org")
  install.packages("data.table", repos="http://cran.r-project.org")
  install.packages("geiger", repos="http://cran.r-project.org")
  install.packages("testit", repos="http://cran.r-project.org")
  install.packages("phyloch", repos="http://cran.r-project.org")
  install.packages("phytools", repos="http://cran.r-project.org")
  install.packages("PBD", repos="http://cran.r-project.org")
  install.packages("RColorBrewer", repos="http://cran.r-project.org")
  install.packages("data.table", repos="http://cran.r-project.org")
  install.packages("phangorn", repos="http://cran.r-project.org")
  install.packages("nLTT", repos="http://cran.r-project.org")
  devtools::install_github("richelbilderbeek/rBEAST")
  devtools::install_github("richelbilderbeek/ribir")
}