#!/bin/bash

##########################
# Clean up
##########################
rm *.txt
rm *.log
rm *.RDa
rm *.csv
rm *.pdf
##########################
# Create parameter files
##########################

jobid=`sbatch create_test_parameter_files.sh | cut -d ' ' -f 4`
#jobid=`sbatch create_parameter_files_article.sh | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# Check parameter file creation success
##########################

cmd="sbatch --dependency=afterok:$jobid collect_parameters.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# Add pbd_sim_output
# This is a parallel job, 
# which is started in run_1.sh
##########################

cmd="sbatch --dependency=afterok:$jobid run_1.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid