#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=add_pdb_output
#SBATCH --output=add_pbd_output_%j.log
module load R
time Rscript -e "library(Cer2016); add_pbd_output(\"$1\")"
