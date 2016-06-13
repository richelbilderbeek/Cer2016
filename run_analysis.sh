#!/bin/bash
Rscript -e 'devtools::install_github("richelbilderbeek/Cer2016")'
Rscript -e 'source("scripts/collect_n_taxa.R")'
mv collected_n_taxa.csv inst/extdata/collected_n_taxa.csv