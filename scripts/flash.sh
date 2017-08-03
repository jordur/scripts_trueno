#! /bin/bash
#SBATCH --job-name="Flash"

cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/${pair1}_good.fastq_pairs_R1.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/${pair2}_good.fastq_pairs_R2.fastq $SLURMTMP

cd $SLURMTMP
/home/ibv/jdurban/programas/FLASH-1.2.11/flash --output-prefix=${pair1} -t 6 ${pair1}_good.fastq_pairs_R1.fastq ${pair2}_good.fastq_pairs_R2.fastq

echo $(date)

mv * /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed

cd /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed

#cat ${pair1}.extendedFrags.fastq *_singles.fastq > ${pair1}_singles.fastq
