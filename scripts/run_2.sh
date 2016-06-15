#!/bin/bash

##########################
# Add species trees
##########################

# add_pbd_outputs.log will be parsed to obtain the jobids
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=add_species_trees
#SBATCH --output=add_species_trees.log
jobids=()
for filename in `ls *.RDa`
do
  cmd="sbatch add_species_trees.sh $filename"
  echo "cmd: "$cmd
  jobids+=(`$cmd | cut -d ' ' -f 4`)
done

txt=$(printf ":%s" "${jobids[@]}")
txt=${txt:1}

############################
# Collect n species trees
############################

cmd="sbatch --dependency=afterok:$txt collect_n_species_trees.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# Add alignments
# This is a parallel job, 
# which is started in run_3.sh
##########################

cmd="sbatch --dependency=afterok:$jobid run_3.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid