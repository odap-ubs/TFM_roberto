#!/bin/bash 
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine) ###This step is only necessary in case your initial files are BAM###
#$ -cwd
#$ -pe smp 8
#$ -N bam_to_fastq
#$ -m ae
#$ -l mf=40G
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q

# Loading samtools

module load apps/samtools-1.8

# Choose the actual folder
path="$1"

# Creating fastq files
mkdir fastq_files

# Choose paths to (change name of bam folder as needed)
cd "${path}/bam_files"
path_to_bam="$(pwd)"
cd "${path}/fastq_files"
path_to_fastq="$(pwd)"

# Coverting all files

for file in ${path_to_bam}/*.bam;do
	# Extract the id
	sample= "$(basename=${file}".bam")"
	# samtools command
	samtools bam2fq file > ${sample}.fastq

done

