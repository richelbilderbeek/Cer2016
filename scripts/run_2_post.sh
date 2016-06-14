#!/bin/bash
#SBATCH --time=0:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1M
#SBATCH --job-name=job_2
#SBATCH --output=job_2.log

# Update the package
Rscript -e 'devtools::install_github("richelbilderbeek/Cer2016")'

# Run local script
Rscript -e 'source("collect_n_taxa.R")'