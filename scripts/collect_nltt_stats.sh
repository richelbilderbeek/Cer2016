#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=collect_nltt_stats
#SBATCH --output=collect_nltt_stats.log
module load R
time Rscript collect_nltt_stats.R
