#!/bin/bash
#SBATCH --time=0:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=test_pdf
#SBATCH --output=test_pdf.log
module load R/3.3.1-foss-2016a
time Rscript test_pdf.R
