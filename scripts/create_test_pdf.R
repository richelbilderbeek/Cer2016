library(Cer2016)
library(knitr)
library(rmarkdown)

# Info for issue #71
cat(Sys.which("pandoc"), file = "create_test_pdf.log", append = TRUE)
cat(system("pandoc -v"), file = "create_test_pdf.log", append = TRUE)
Sys.setenv(RSTUDIO_PANDOC="/usr/bin/pandoc") 
cat(Sys.which("pandoc"), file = "create_test_pdf.log", append = TRUE)
cat(system("pandoc -v"), file = "create_test_pdf.log", append = TRUE)

# Knitr

tryCatch(
  knitr::knit("../vignettes/troubleshooting.Rmd", "troubleshooting_knitr.pdf"),
  error = function(msg) { message(msg) }
)

# Pandoc with squiggle

tryCatch(
  rmarkdown::render("../vignettes/troubleshooting.Rmd", output_file = "~/troubleshooting_pandoc.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc ~/troubleshooting_pandoc.html -o troubleshooting_pandoc.pdf"),
  error = function(msg) { message(msg) }
)

# Pandoc with full path

tryCatch(
  rmarkdown::render("../vignettes/troubleshooting.Rmd", output_file = "/home/p230198/troubleshooting_pandoc.html"),
  error = function(msg) { message(msg) }
)

tryCatch(
  system("pandoc /home/p230198/troubleshooting_pandoc.html -o troubleshooting_pandoc.pdf"),
  error = function(msg) { message(msg) }
)
