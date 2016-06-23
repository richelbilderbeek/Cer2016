#!/bin/bash
# Called from scripts folder by run.sh
#SBATCH --time=0:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1M
#SBATCH --job-name=create_parameter_files_article
#SBATCH --output=create_parameter_files_article.log
#SBATCH --mail-type=BEGIN,END
module load R
time Rscript -e 'library(Cer2016); create_parameter_files_article()'
