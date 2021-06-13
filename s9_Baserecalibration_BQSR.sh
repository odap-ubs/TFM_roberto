#!/bin/bash
#$ -cwd
#$ -pe smp 7
#$ -N recal
#$ -m ae
#$ -l mf=44G
#$ -M rfornelino@idibell.cat
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q@compute-0-0

# --------------------------
# 4.2 BASE RECALIBRATION
# --------------------------


# Loading samtools and gatk
module load apps/java-9.0.4 apps/samtools-1.8 apps/gatk-4.0.6



# Choose the actual folder
path="$1"

# Creating fastq files
mkdir base_recalibration_files

# Choose paths to (change name of bam folder as needed)
cd "${path}/splitncigar_files"
path_to_split="$(pwd)"
cd "${path}/base_recalibration_files"
path_to_recal="$(pwd)"


# Databases
dbsnp="references/All_20180423_nochr.vcf.gz"
indels="references/Mills_and_1000G_gold_standard.indels.b37.vcf"
# Reference
ref_hg19="references/genome.fa"

# perform base recalibration
for file in ${path_to_split}/*_splited.bam; do
        sample="$(basename ${file} "_splited.bam")"
        # 1) Recalibrate and Generate table
        gatk BaseRecalibrator -I "${path_to_split}/${sample}_splited.bam" -R "${ref_hg19}" --known-sites "${indels}" --known-sites "${dbsnp}" -O "${path_to_recal}/${sample}_recalibrated.table"
        # 2) Apply recalibration to data
        gatk ApplyBQSR -I "${path_to_split}/${sample}_splited.bam" -R  "${ref_hg19}" --bqsr-recal-file "${path_to_recal}/${sample}_recalibrated.table" -O "${path_to_recal}/${sample}_recal.bam"
done







mkdir base_recalibration_files/normal
cd "${path}/base_recalibration_files"
mv *_normal_recal.bam base_recalibration_files/normal

mkdir base_recalibration_files/tumor
cd "${path}/base_recalibration_files"
mv *_tumor_recal.bam base_recalibration_files/tumor

