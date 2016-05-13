## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
all_parameter_filenames <- c(
  find_path("article_0_0_0_0_0.RDa"),
  find_path("article_0_1_4_0_2.RDa"),
  find_path("toy_example_1.RDa")
)
show_parameter_files(all_parameter_filenames, verbose = TRUE)

## ------------------------------------------------------------------------
folder <- "/home/p230198/Peregrine" # nolint
really_show_all <- FALSE # Set to TRUE for a long wait
all_parameter_filenames <- paste(folder, list.files(folder, pattern = "\\.RDa"), sep = "/")
if (really_show_all) {
  show_parameter_files(all_parameter_filenames, verbose = TRUE)
} else {
  show_parameter_files(head(all_parameter_filenames), verbose = TRUE)
}

## ------------------------------------------------------------------------
pcname <- system("uname -n", intern = TRUE) 
if (pcname == "Aline") {
  setwd("c:/Users/Aline/Peregrine") # nolint
  getwd()
  # Put all .RDA files in a variable
  all_parameters <- Sys.glob("*.RDa") # alternative, but longer: all_parameters <- list.files(pattern = "\\.RDa$", ignore.case=TRUE)
  print(all_parameters)
  
  file.exists(all_parameters)
  
  show_parameter_files(all_parameters)
}

## ------------------------------------------------------------------------
#---------------------Example---------------------------------
#filename <- filenames[1]
#filename <- "d:/Peregrine/article_0_0_0_0_0.RDa"
#filename <- "toy_example_1.RDa"
#readRDS(filename)
#file.exists(filename)
#file <- read_file(filename)
#names(file)


