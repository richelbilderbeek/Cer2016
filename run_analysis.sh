#!/bin/bash
Rscript -e 'devtools::install_github("richelbilderbeek/Cer2016")'
Rscript -e 'source("scripts/collect_n_taxa.R")'