#!/bin/bash
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine)
#$ -cwd
#$ -pe smp 7
#$ -N rg
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
mkdir read_groups_files

# Choose paths to 
cd "${path}/expression/mapping/genome"
path_to_alignment="$(pwd)"
cd "${path}/read_groups_files"
path_to_rehead="$(pwd)"


# read groups ids for tumor samples
for file in ${path_to_alignment}/*_tumor_Aligned.sortedByCoord.out.bam; do
    sample="$(basename ${file} "_tumor_Aligned.sortedByCoord.out.bam")"

    java -jar $PICARD AddOrReplaceReadGroups I=${path_to_alignment}/${sample}_tumor_Aligned.sortedByCoord.out.bam  O=${path_to_rehead}/${sample}_tumor_Aligned.sortedByCoord_read_group.bam  RGID=${sample} RGLB=rnaseq RGPL=illumina RGPU=star RGSM=${sample}_tumor

done



# read groups ids for tumor samples
for file in ${path_to_alignment}/*_normal_Aligned.sortedByCoord.out.bam; do
    sample="$(basename ${file} "_normal_Aligned.sortedByCoord.out.bam")"

    java -jar $PICARD AddOrReplaceReadGroups I=${path_to_alignment}/${sample}_normal_Aligned.sortedByCoord.out.bam  O=${path_to_rehead}/${sample}_normal_Aligned.sortedByCoord_read_group.bam  RGID=${sample} RGLB=rnaseq RGPL=illumina RGPU=star RGSM=${sample}_normal

done
