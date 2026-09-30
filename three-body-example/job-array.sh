#!/bin/bash

### Job Array:
#SBATCH --array 1-5000%128

### Array Task Parameters:
#SBATCH --job-name  "Three-Body Task" # display name
#SBATCH --output    "logs/out.%a.log"   # where to log terminal output 
#SBATCH --error     "logs/err.%a.log"   #  .. and error messages
#SBATCH --open-mode append

#SBATCH --partition batch-cpu
#SBATCH --qos project-cpu
#SBATCH --account projects

# Resources required
#SBATCH --ntasks 1          # number of tasks we'll perform
#SBATCH --cpus-per-task 1   # num. cpus each task will require
#SBATCH --mem-per-cpu 1024  # memory required per cpu (in megabytes)

### Script To Execute:

# create places to hold results
mkdir -p "logs" "imgs"

# load deps (OR ALTERNATIVELY: Activate virtual environment.)
module load foss/2022a Python/3.10.4 SciPy-bundle matplotlib

# use the SLURM task id to select parameters from list.
param_args=$(sed -n ${SLURM_ARRAY_TASK_ID}p "parameters.txt")

# run code with selected parameters
python three_body.py $param_args 

