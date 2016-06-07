#!/bin/bash
# Call from root folder with with 'sbatch ./scripts/add_pdb_output example.xml'
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --ntasks=8
#SBATCH --mem=1G
#SBATCH --job-name=add_pdb_output
#SBATCH --mail-type=BEGIN,END
module load R/3.2.1-goolfc-2.7.11-default
Rscript -e 'devtools::install_github("richelbilderbeek/Cer2016"); library(Cer2016); add_pbd_output($1)'