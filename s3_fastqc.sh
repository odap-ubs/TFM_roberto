#!/bin/bash 
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine)
#$ -cwd
#$ -pe smp 8
#$ -N fastqc
#$ -m ae
#$ -l mf=40G
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q

# Load fastqc software
module load apps/java-9.0.4 apps/fastqc-0.11.7

# Choose the actual folder
path="$1"



# Create folder for pfastqc
mkdir fastqc_files

# Choose paths to 
cd "${path}/fastq_files"
path_to_fastq_pair_end="$(pwd)"
cd "${path}/fastqc_files"
path_to_fastqc="$(pwd)"

# Executing fastqc
for file in ${path_to_fastq}/*.fastq; do
        fastqc ${file} -o ${path_to_fastqc}
done
