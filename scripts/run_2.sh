#!/bin/bash
# Call this file from this project root by './scripts/run_2.sh'
for filename in `ls *.RDa`
do
  echo $filename
  #sbatch ./scripts/add_pbd_output.sh
done