## ------------------------------------------------------------------------
if (is.element("beastscriptr", installed.packages()[,1])) {
  print("package is already installed")
} else {
  devtools::install_github("richelbilderbeek/beastscriptr")
}

## ------------------------------------------------------------------------
if (is.element("adephylo", installed.packages()[,1])) {
  print("package is already installed")
} else {
  install.packages("adephylo", repos = "http://cran.uk.r-project.org")
}

## ------------------------------------------------------------------------
if (is.element("rBEAST", installed.packages()[,1])) {
  print("package is already installed")
} else {
  devtools::install_github("richelbilderbeek/rBEAST")
}

## ------------------------------------------------------------------------
if (is.element("ribir", installed.packages()[,1])) {
  print("package is already installed")
} else {
  devtools::install_github("richelbilderbeek/ribir")
}

