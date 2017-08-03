#! /bin/bash
#SBATCH --job-name="Trimmomatic"
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${pair1} $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${pair2} $SLURMTMP
cd $SLURMTMP
echo $(date)

java -jar /home/ibv/jdurban/programas/Trimmomatic-0.35/trimmomatic-0.35.jar PE -threads 6 -phred33 ${pair1} ${pair2} ${sample}_R1-paired.fastq ${sample}_R1_unpaired.fastq ${sample}_R2-paired.fastq ${sample}_R2_unpaired.fastq ILLUMINACLIP:/home/ibv/jdurban/programas/Trimmomatic-0.35/adapters/NexteraPE-PE.fa:2:40:15 SLIDINGWINDOW:4:15 LEADING:3 TRAILING:3 MINLEN:90 HEADCROP:9 

echo $(date)

mv * /home/ibv/jdurban/MinION/${sample}/Illumina
exit

#sbatch -p q-low -n 1 ~/scripts/prova.sh

