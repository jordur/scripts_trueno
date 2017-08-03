#!/bin/bash
#SBATCH --job-name="Syncro"
#SBATCH --mem=16G
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${sample}_R1-paired.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${sample}_R2-paired.fastq $SLURMTMP

cd $SLURMTMP
echo $(date)

/home/ibv/jdurban/scripts/fastqCombinePairedEnd.py ${sample}_R1-paired.fastq ${sample}_R2-paired.fastq 

mv * /home/ibv/jdurban/MinION/${sample}/Illumina/

echo $(date)

