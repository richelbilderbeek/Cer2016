#!/bin/bash
# Call this file from this project root by './scripts/run_2.sh'
for filename in `ls *.RDa`
do
  sbatch ./scripts/add_pbd_output.sh
done