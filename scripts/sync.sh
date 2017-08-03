#!/bin/bash
#SBATCH --job-name="Syncro"
#SBATCH --mem=16G
cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/${pair1}_good.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/${pair2}_good.fastq $SLURMTMP

cd $SLURMTMP
echo $(date)

/home/ibv/jdurban/scripts/fastqCombinePairedEnd.py ${pair1}_good.fastq ${pair2}_good.fastq 

mv * /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed

echo $(date)

