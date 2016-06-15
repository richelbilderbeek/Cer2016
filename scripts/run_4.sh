#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=add_posteriors
#SBATCH --output=add_posteriors.log

##########################
# Add posteriors
##########################

jobids=()
for filename in `ls *.RDa`
do
  cmd="sbatch add_posteriors.sh $filename"
  echo "cmd: "$cmd
  jobids+=(`$cmd | cut -d ' ' -f 4`)
done

txt=$(printf ":%s" "${jobids[@]}")
txt=${txt:1}

############################
# Collect n posteriors
############################

cmd="sbatch --dependency=afterok:$txt collect_n_posteriors.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# Analysis
##########################

#cmd="sbatch --dependency=afterok:$jobid run_4.sh"
#echo "cmd: "$cmd
#jobid=`$cmd | cut -d ' ' -f 4`
#echo "jobid: "$jobid