#! /bin/bash
#SBATCH --job-name="Flash"

cp /home/ibv/jdurban/MinION/${sample}/Illumina/${sample}_R1-paired.fastq_pairs_R1.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${sample}_R2-paired.fastq_pairs_R2.fastq $SLURMTMP

cd $SLURMTMP
/home/ibv/jdurban/programas/FLASH-1.2.11/flash -t 6 ${sample}_R1-paired.fastq_pairs_R1.fastq ${sample}_R2-paired.fastq_pairs_R2.fastq

echo $(date)

mv * /home/ibv/jdurban/MinION/${sample}/Illumina

cd /home/ibv/jdurban/MinION/${sample}/Illumina

cat out.extendedFrags.fastq Ecoli_R2_unpaired.fastq Ecoli_R1_unpaired.fastq > singles.fastq
