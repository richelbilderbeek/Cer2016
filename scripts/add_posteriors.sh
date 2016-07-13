#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --ntasks=8
#SBATCH --mem=1G
#SBATCH --job-name=add_posteriors
#SBATCH --output=add_posteriors_%j.log
module load R/3.2.3-foss-2016a beagle-lib Beast
time Rscript -e "library(Cer2016); add_posteriors(\"$1\")"
