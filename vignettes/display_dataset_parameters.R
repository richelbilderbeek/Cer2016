## ------------------------------------------------------------------------
library(Cer2016)

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


