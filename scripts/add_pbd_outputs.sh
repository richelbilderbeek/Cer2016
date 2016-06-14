#!/bin/bash
jobids=()
for filename in `ls *.RDa`
do
  cmd="sbatch --dependency=afterok:$1 add_pbd_output.sh $filename"
  echo "cmd: "$cmd
  jobids+=(`$cmd | cut -d ' ' -f 4`)
done

txt=$(printf ":%s" "${jobids[@]}")
txt=${txt:1}
echo $txt

