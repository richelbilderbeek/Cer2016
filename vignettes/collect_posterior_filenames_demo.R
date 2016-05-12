## ------------------------------------------------------------------------
library(Cer2016)

## ------------------------------------------------------------------------
parameter_filename <- find_path("toy_example_1.RDa")
posterior_filenames <- collect_posterior_filenames(parameter_filename)
knitr::kable(posterior_filenames)

## ------------------------------------------------------------------------
parameter_filename <- find_path("toy_example_4.RDa")
posterior_filenames <- collect_posterior_filenames(parameter_filename)
knitr::kable(posterior_filenames)

