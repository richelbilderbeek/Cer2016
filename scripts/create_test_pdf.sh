#!/bin/bash
#SBATCH --time=0:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=create_test_pdf
#SBATCH --output=create_test_pdf.log
module load R
time Rscript create_test_pdf.R
