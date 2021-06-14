#!/bin/bash
#$ -cwd
#$ -pe smp 8
#$ -S /bin/bash
#$ -q all.q
#$ -m ae
#$ -l mf=40G 
#$ -N pipeline_expression_rna
#$ -M rfornelino@idibell.cat
#$ -o $JOB_NAME.out
#$ -e $JOB_NAME.err
#$ -j y

This pipeline needs of the function pipe_rnaseq.py to work
# Loading tools
module load apps/trimmomatic-0.38 apps/java-9.0.4 apps/fastqc-0.11.7 apps/star-2.6.0 apps/rsem-1.3.1 apps/rseqc-3.0.0 apps/python-2.7.15 apps/R-3.5.0 apps/bbmap-38.26

ulimit -n 4050

# running the whole process with trimmomatic
# withouth performing FastQC
# without specifying end type and strandedness
python2 pipe_rnaseq_v0.8.py --input-folder paired/ --output-folder expresion/ --cores 7 --trim-mode notrim --ref-index references/ --quant-index rsem_ref/ --fastqc False
