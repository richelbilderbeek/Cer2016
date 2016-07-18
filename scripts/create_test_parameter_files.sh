#!/bin/bash
# Called from scripts folder by run.sh
#SBATCH --time=0:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1M
#SBATCH --job-name=create_test_parameter_files
#SBATCH --output=create_test_parameter_files.log
module load R/3.3.1-foss-2016a
time Rscript -e 'library(Cer2016); create_test_parameter_files()'
