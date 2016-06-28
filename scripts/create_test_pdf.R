library(Cer2016)
library(knitr)
library(rmarkdown)

# Info for issue #71
print(Sys.which("pandoc"))
print(system("pandoc -v"))
Sys.setenv(RSTUDIO_PANDOC="/usr/bin/pandoc") 
print(Sys.which("pandoc"))
print(system("pandoc -v"))

tryCatch(
  knitr::knit("../vignettes/troubleshooting.Rmd", "troubleshooting_knitr.pdf"),
  error = function(msg) { message(msg) }
)

tryCatch(
  rmarkdown::render("../vignettes/troubleshooting.Rmd", output_file = "~/troubleshooting_pandoc.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/troubleshooting_pandoc.html -o troubleshooting_pandoc.pdf"),
  error = function(msg) { message(msg) }
)
