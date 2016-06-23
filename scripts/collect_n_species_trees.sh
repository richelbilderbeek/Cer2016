#!/bin/bash
# Called from scripts folder by run.sh
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=collect_n_species_trees
#SBATCH --output=collect_n_species_trees.log
module load R
time Rscript collect_n_species_trees.R
