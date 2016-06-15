#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=collect_n_alignments
#SBATCH --output=collect_n_alignments.log
module load R
Rscript collect_n_alignments.R