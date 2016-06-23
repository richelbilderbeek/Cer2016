#!/bin/bash
#SBATCH --time=0:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=add_alignments
#SBATCH --output=add_alignments_%j.log
module load R
time Rscript -e "library(Cer2016); add_alignments(\"$1\")"
