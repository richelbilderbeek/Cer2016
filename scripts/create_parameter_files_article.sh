#!/bin/bash
# Call from root folder with 'sbatch ./scripts/create_parameter_files_article.sh'
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --ntasks=4
#SBATCH --mem=1G
#SBATCH --job-name=create_parameter_files_article
#SBATCH --mail-type=BEGIN,END
module load R
Rscript -e 'library(Cer2016); create_parameter_files_article()'