#!/bin/bash
# Argumentos necesarios para lanzar el codigo en el cluster (not necesary if running in local machine) ###This step is only necessary in case your initial files are BAM###
#$ -cwd
#$ -pe smp 7
#$ -N mutect2_non
#$ -m ae
#$ -l mf=40G
#$ -M rfornelino@idibell.cat
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y
#$ -S /bin/bash
#$ -q all.q

# --------------------------
# 5.1 GATK MUTECT2
# --------------------------



# Loading gatk
module load apps/java-9.0.4
module load apps/gatk-4.0.6



# Choose the actual folder
path="$1"

# Creating fastq files
mkdir mutect_apareado_files

# Choose paths to (change name of bam folder as needed)
cd "${path}/base_recalibration_files"
path_to_="$(pwd)"
cd "${path}/mutect_apareado_files"
path_to_variants="$(pwd)"


# Paths

path_to_alignments="path_to/tumor"
path_to_alignments2="path_to/normal"


# Reference
ref_hg19="reference/genome.fa"
gnomad="reference/somatic-b37_af-only-gnomad.raw.sites.vcf"

# perform variant calling
for file in ${path_to_alignments}/*_tumor_recal.bam; do
        sample="$(basename ${file} "_tumor_recal.bam")"
        tumor="${path_to_alignments}/${sample}_tumor_recal.bam"
	normal="${path_to_alignments2}/${sample}_normal_recal.bam"
        gatk Mutect2 -R ${ref_hg19} -I ${tumor} -tumor ${sample}_tumor -I ${normal} -normal ${sample}_normal --germline-resource ${gnomad} --af-of-alleles-not-in-resource 0.0000025 -O ${path_to_variants}/${sample}_som_vars_mutect2.vcf.gz
done
