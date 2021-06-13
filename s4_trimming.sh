#!/bin/bash
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine)
#$ -cwd
#$ -pe smp 8
#$ -N rna_trimado
#$ -m ae
#$ -l mf=18G
#$ -M rfornelino@idibell.cat
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q

# --------------------------
# 2 TRIMMING
# --------------------------

# Folder


# Loading Trimmomatic
module load apps/java-9.0.4
module load apps/trimmomatic-0.38


# Choose the actual folder
path="$1"



# Create folder for pfastqc
mkdir trimming_files

# Choose paths to 
cd "${path}/fastq_files"
path_to_fastq_pair_end="$(pwd)"
cd "${path}/trimming_files"
path_to_trimming="$(pwd)"


# Running trimming
for file in ${path_to_fastq_pair_end}/*_R1.fastq; do
        base=$(basename ${file} "_R1.fastq")
        java -jar $TRIMMOMATIC PE \
                -phred33 -threads 10 -trimlog trimlog.txt \
                "${path_to_fastq}/${base}_R1.fastq" \
                "${path_to_fastq}/${base}_R2.fastq" \
                "${path_to_trimmed}/${base}_R1_paired.fastq" \
                "${path_to_trimmed}/${base}_R1_unpaired.fastq" \
                "${path_to_trimmed}/${base}_R2_paired.fastq" \
                "${path_to_trimmed}/${base}_R2_unpaired.fastq" \
                LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 HEADCROP:2 # This arguments can be changed 
done
