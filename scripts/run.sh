#!/bin/bash

rm *.txt
rm *.log
rm *.RDa

##########################
# Create parameter files
##########################

jobid=`sbatch create_test_parameter_files.sh | cut -d ' ' -f 4`
#jobid=`sbatch create_parameter_files_article.sh | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# After parameter file creation
# 1) 1x check its success: collect_parameters
##########################

cmd="sbatch --dependency=afterok:$jobid collect_parameters.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# After parameter file creation
# 2) 4x add pbd_sim_output
##########################

cmd="sbatch --dependency=afterok:$jobid add_pbd_outputs.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# After pbd_sim_output
# 1) 1x Check its success: collect_n_taxa
# - 4x Add species trees
##########################

cmd="sbatch --dependency=afterok:$jobid collect_n_taxa.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid


cat add_pbd_outputs.log | tail -n 1