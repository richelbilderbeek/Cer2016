#!/bin/bash

##########################
# Create parameter files
##########################

jobid=`sbatch create_test_parameter_files.sh | cut -d ' ' -f 4`
#jobid=`sbatch create_parameter_files_article.sh | cut -d ' ' -f 4`
echo "job id of first script is "$jobid

##########################
# After parameter file creation
# - 1x Check its success: collect_parameters
# - 4x Add pbd_sim_output
##########################

# 1) Check its success: collect_parameters
cmd="sbatch --dependency=afterok:$jobid collect_parameters.sh"
echo "cmd: "$cmd
jobid_collect_parameters=`$cmd | cut -d ' ' -f 4`
echo "job id of the collect_parameters script is "$jobid_collect_parameters

# 2) Add pbd_sim_output
cmd="sbatch --dependency=afterok:$jobid add_pbd_outputs.sh"
echo "cmd: "$cmd

jobids=`$cmd`
echo "jobids:"
echo $jobids