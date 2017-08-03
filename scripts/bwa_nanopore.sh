#!/bin/sh 
#SBATCH --job-name="BWA"
#SBATCH --mem=20G

dir=/home/ibv/jdurban/MinION/Bjararaca;

for uniqueBC in `ls $dir/*.fastq | xargs -n1 basename`; do
	uniqueBC=`echo "$uniqueBC" | sed "s/_good.fastq//"`
#	echo $uniqueBC
	cp /home/ibv/jdurban/MinION/${sample}/${uniqueBC}_good.fastq $SLURMTMP
	cp /home/ibv/jdurban/MinION/${sample}/Canu_assembly_${sample}_${uniqueBC}/Canu_assembly_${sample}_${uniqueBC}.contigs.fasta $SLURMTMP
	mkdir -p /home/ibv/jdurban/MinION/${sample}/map_${uniqueBC}
	cd $SLURMTMP
	echo $(date)

	bwa index Canu_assembly_${sample}_${uniqueBC}.contigs.fasta
	bwa mem -t 16 -k 16 -W 60 -r 10 -A 1 -B 1 -O 1 -E 1 -L 0 Canu_assembly_${sample}_${uniqueBC}.contigs.fasta ${uniqueBC}_good.fastq > ${sample}_${uniqueBC}.contigs.sam
#bwa mem -t 16 -k 16 -W 60 -r 10 -A 1 -B 1 -O 1 -E 1 -L 0 Canu_assembly_${sample}.contigs.fasta ${sample}_collapse.fastq > ${sample}.contigs_tulip.sam
	samtools view -bS ${sample}_${uniqueBC}.contigs.sam | samtools sort - ${sample}_${uniqueBC}.contigs.sorted
	samtools index ${sample}_${uniqueBC}.contigs.sorted.bam

echo $(date)

	mv ${sample}_${uniqueBC}.contigs.sorted.bam* /home/ibv/jdurban/MinION/${sample}/map_${uniqueBC}
done
exit

#sbatch -p q-low -n 1 ~/scripts/bwa
#sbatch -p q-low --dependency=afterok:18875 -n 1 ~/scripts/bwa
