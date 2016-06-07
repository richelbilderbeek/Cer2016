#!/bin/bash
# Call from root folder with with 'sbatch ./scripts/test_package'
# 10 hours suffices
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=test_package
#SBATCH --mail-type=BEGIN,END
module load R
R CMD check .