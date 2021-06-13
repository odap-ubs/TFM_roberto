#!/bin/bash 
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine)
#$ -cwd
#$ -pe smp 8
#$ -N separar_separar
#$ -m ae
#$ -l mf=40G
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q


# Choose the actual folder
path="$1"

# Create folder for pair end
mkdir fastq_files_pair_end

# Choose paths to 
cd "${path}/fastq_files"
path_to_fastq="$(pwd)"
cd "${path}/fastq_files_pair_end"
path_to_fastq_pair_end="$(pwd)"

# Hacemos un loop para separar los fastq en pair end
for file in ${path_to_fastq}/*.fastq; do
	# Extract id
	base=$(basename ${file} ".fastq")
	cat ${file} | grep '^@.*/1$' -A 3 --no-group-separator > ${base}_R1.fastq
	cat ${file} | grep '^@.*/2$' -A 3 --no-group-separator > ${base}_R2.fastq

done
