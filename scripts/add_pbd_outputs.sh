#!/bin/bash
# add_pbd_outputs.log will be parsed to obtain the jobids
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=add_pdb_outputs
#SBATCH --output=add_pbd_outputs.log
jobids=()
for filename in `ls *.RDa`
do
  cmd="sbatch add_pbd_output.sh $filename"
  echo "cmd: "$cmd
  jobids+=(`$cmd | cut -d ' ' -f 4`)
done

txt=$(printf ":%s" "${jobids[@]}")
txt=${txt:1}
echo $txt 



