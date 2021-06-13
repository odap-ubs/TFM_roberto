#!/bin/bash
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine)
#$ -cwd
#$ -pe smp 7
#$ -N mark_duplicates
#$ -m ae
#$ -l mf=40G
#$ -M rfornelino@idibell.cat
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q@compute-0-0

# Loading Picardtools
module load apps/java-9.0.4 apps/picardtools-2.18.11


# Choose the actual folder
path="$1"



# Create folder for read_groups
mkdir marked_duplicates

# Choose paths to 
cd "${path}/read_groups"
path_to_read_groups="$(pwd)"
cd "${path}/marked_duplicates"
path_to_marked_duplicates="$(pwd)"


for file in ${path_to_read_groups}/*_Aligned.sortedByCoord_read_group.bam; do
        sample="$(basename ${file} "_Aligned.sortedByCoord_read_group.bam")"
        java -jar $PICARD MarkDuplicates I=${path_to_read_groups}/${file} O=${path_to_marked_duplicates}/${sample}_marked_duplicates.bam M=${sample}_marked_dup_metrics.txt CREATE_INDEX=True ASSUME_SORT_ORDER=coordinate
done
