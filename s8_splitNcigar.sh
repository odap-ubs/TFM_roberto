#!/bin/bash
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine)
#$ -cwd
#$ -pe smp 7
#$ -N splitncigar
#$ -m ae
#$ -l mf=40G
#$ -M rfornelino@idibell.cat
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q@compute-0-0


#Loading gatk
module load apps/java-9.0.4 module load apps/gatk-4.0.6

# Choose the actual folder
path="$1"

# Create folder for pair end
mkdir splitncgiar_files

# Choose paths to 
cd "${path}/marked_duplicates"
path_to_marked_duplicates="$(pwd)"
cd "${path}/splitncigar_files"
path_to_splitncigar="$(pwd)"



for file in ${path_to_marked_duplicates}/*_marked_duplicates.bam;do
        sample="$(basename ${file} "_marked_duplicates.bam")"
        gatk SplitNCigarReads -R '/mnt/mimas/projects/2020_RNA_seq_neoantigens/Roberto/hg19_sequence/genome.fa' -I ${file} -O "${path_to_splitncigar}/${sample}_splited.bam"
done
