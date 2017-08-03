#!/bin/sh 
#SBATCH --job-name="BWA"
cp /home/ibv/jdurban/MinION/${sample}/${sample}_collapse.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Canu_assembly_${sample}/Canu_assembly_${sample}.unitigs.fasta $SLURMTMP
mkdir -p /home/ibv/jdurban/MinION/${sample}/map
cd $SLURMTMP
echo $(date)

bwa index Canu_assembly_${sample}.unitigs.fasta
bwa mem -t 16 -x ont2d Canu_assembly_${sample}.unitigs.fasta ${sample}_collapse.fastq > ${sample}.unitigs.sam
samtools view -bS ${sample}.unitigs.sam | samtools sort - ${sample}.unitigs.sorted
samtools index ${sample}.unitigs.sorted.bam

echo $(date)

mv ${sample}.unitigs.sorted.bam* /home/ibv/jdurban/MinION/${sample}/map
exit

#sbatch -p q-low -n 1 ~/scripts/bwa
#sbatch -p q-low --dependency=afterok:18875 -n 1 ~/scripts/bwa
