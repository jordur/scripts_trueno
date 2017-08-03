#! /bin/bash
#SBATCH --job-name="FastQC proc"
#SBATCH --mem=80G
for i in NB01_good.fastq NB02_good.fastq NB03_good.fastq NB04_good.fastq NB05_good.fastq NB06_good.fastq NB07_good.fastq NB08_good.fastq; do

cp /home/ibv/jdurban/MinION/Bjararaca/${i} $SLURMTMP

#cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/${pair1}.notCombined_1.fastq $SLURMTMP
#cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/${pair2}.notCombined_2.fastq $SLURMTMP
#cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/${pair1}_singles.fastq $SLURMTMP
cd $SLURMTMP
echo $(date)

/home/ibv/jdurban/programas/FastQC_dev/fastqc --nano -o /home/ibv/jdurban/MinION/Bjararaca ${i}
#fastqc -t 6 ${pair1}.notCombined_1.fastq 
#fastqc -t 6 ${pair2}.notCombined_2.fastq 
#fastqc -t 6 ${pair1}_singles.fastq

echo $(date)

#mv * /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/fastqc
mv * /home/ibv/jdurban/MinION/Bjararaca
done
exit

#sbatch -p q-low -n 1 ~/scripts/prova.sh
