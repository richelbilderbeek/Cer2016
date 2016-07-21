#!/bin/bash
#SBATCH --time=0:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --job-name=add_species_trees
#SBATCH --output=add_species_trees_%j.log
module load R/3.3.1-foss-2016a
time Rscript -e "library(Cer2016); add_species_trees(\"$1\")"
