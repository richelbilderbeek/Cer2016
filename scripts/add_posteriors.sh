#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --ntasks=8
#SBATCH --mem=1G
#SBATCH --job-name=add_posteriors
#SBATCH --output=add_posteriors_%j.log
module load R beagle-lib Beast
Rscript -e "library(Cer2016); add_posteriors(\"$1\")"
