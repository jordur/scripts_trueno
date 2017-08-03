#! /bin/bash
#SBATCH --job-name="FastQC proc"
cp /home/ibv/jdurban/MinION/${sample}/Illumina/out.notCombined_1.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/out.notCombined_2.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/singles.fastq $SLURMTMP
cd $SLURMTMP
echo $(date)

fastqc -t 6 out.notCombined_1.fastq 
fastqc -t 6 out.notCombined_2.fastq 
fastqc -t 6 singles.fastq

echo $(date)

mv * /home/ibv/jdurban/MinION/${sample}/Illumina
exit

#sbatch -p q-low -n 1 ~/scripts/prova.sh
