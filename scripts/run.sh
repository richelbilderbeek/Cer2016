#!/bin/bash

##########################
# Clean up
##########################
rm *.txt
rm *.log
rm *.RDa
rm *.csv
rm *.pdf
rm *.md

##########################
# Update other packages
##########################

jobid=`sbatch install_r_packages.sh | cut -d ' ' -f 4`
echo "jobid: "$jobid


##########################
# Update this package
##########################

cmd="sbatch --dependency=afterok:$jobid install_this_r_package.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# Create parameter files
##########################


# Trivial test runs
# cmd="sbatch --dependency=afterok:$jobid create_test_parameter_files.sh"
# 1% of MCMC run
cmd="sbatch --dependency=afterok:$jobid create_parameter_files_timings.sh"
# Full run
#cmd="sbatch --dependency=afterok:$jobid create_parameter_files_article.sh"

echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# Check parameter file creation success
##########################

cmd="sbatch --dependency=afterany:$jobid collect_parameters.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# Add pbd_sim_output
# This is a parallel job, 
# which is started in run_1.sh
##########################

cmd="sbatch --dependency=afterany:$jobid run_1.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid
