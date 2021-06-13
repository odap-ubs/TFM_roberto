#!/bin/bash
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine) ###This step is only necessary in case your initial files are BAM###
#$ -cwd
#$ -pe smp 7
#$ -N haplitypecaller
#$ -m ae
#$ -l mf=40G
#$ -M rfornelino@idibell.cat
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q@compute-0-0

# Loading gatk
module load apps/gatk-4.0.6

# Choose the actual folder
path="$1"

# Creating haplotypecaller files
mkdir haplotypecaller_files

# Choose paths to (change name of bam folder as needed)
cd "${path}/base_recalibration_files"
path_to_recal="$(pwd)"
cd "${path}/haplotypecaller_files"
path_to_haplotypecaller="$(pwd)"


for file in ${path_to_recal}/*_recal.bam;do
        base=$(basename ${file} "_recal.bam")
        gatk HaplotypeCaller -R 'references/genome.fa' -I ${path_to_recal}/${base}_recal.bam -stand-call-conf 20.0 --dont-use-soft-clipped-bases true -O ${path_to_haplotypecaller}/${base}_variant_haplo.vcf --native-pair-hmm-threads 10

done
