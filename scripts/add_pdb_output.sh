#!/bin/bash
# Call from root folder with with 'sbatch ./scripts/add_pdb_output example.xml'
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --ntasks=8
#SBATCH --mem=1G
#SBATCH --job-name=add_pdb_output
#SBATCH --output=add_pbd_output_%.log
#SBATCH --mail-type=BEGIN,END
module load R
Rscript -e 'library(Cer2016); add_pbd_output($1)'