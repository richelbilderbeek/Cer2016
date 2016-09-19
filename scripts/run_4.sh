#!/bin/bash
#SBATCH --time=0:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=run_4
#SBATCH --output=run_4.log

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

cmd="sbatch --dependency=afterany:$txt collect_n_posteriors.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
# Analysis
##########################

cmd="sbatch --dependency=afterany:$jobid collect_esses.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

cmd="sbatch --dependency=afterany:$jobid collect_gammas.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

cmd="sbatch --dependency=afterany:$jobid collect_nrbss.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

cmd="sbatch --dependency=afterany:$jobid collect_nltts.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

cmd="sbatch --dependency=afterany:$jobid collect_nltt_stats.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

cmd="sbatch --dependency=afterany:$jobid collect_times.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

cmd="sbatch --dependency=afterany:$jobid analyse_esses.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid


cmd="sbatch --dependency=afterany:$jobid analyse_nltt_stats.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

cmd="sbatch --dependency=afterany:$jobid analyse_time.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

cmd="sbatch --dependency=afterany:$jobid send_me_an_email.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid
