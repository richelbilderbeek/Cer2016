#!/bin/bash
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --ntasks=8
#SBATCH --mem=10G
#SBATCH --job-name=add_posteriors
#SBATCH --output=add_posteriors_%j.log
module load R/3.3.1-foss-2016a beagle-lib Beast
time Rscript -e "library(Cer2016); add_posteriors(\"$1\")"
