#!/bin/bash
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=test_package
#SBATCH --output=test_package.log
#SBATCH --mail-type=BEGIN,END
module load R/3.3.1-foss-2016a
R CMD check .
