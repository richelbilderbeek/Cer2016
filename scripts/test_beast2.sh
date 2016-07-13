#!/bin/bash
#SBATCH --time=0:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=test_beast2
#SBATCH --output=test_beast2.log
module load R/3.3.1-foss-2016a
time Rscript test_beast2.R
