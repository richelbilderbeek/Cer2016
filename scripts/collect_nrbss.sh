#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=collect_nrbss
#SBATCH --output=collect_nrbss.log
module load R/3.2.3-foss-2016a
time Rscript collect_nrbss.R
