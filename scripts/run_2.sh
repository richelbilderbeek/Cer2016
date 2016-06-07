#!/bin/bash
# Call this file from this project root by './scripts/run_2.sh'
for filename in `ls *.RDa`
do
  sbatch ./add_pbd_output.sh $filename
done