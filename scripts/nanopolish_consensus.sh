#!/bin/sh 
#SBATCH --job-name="Consensus"
#SBATCH --mem=62G

export tmpnano=/scratch-global/$SLURM_JOB_USER

#number_of_dirs=`ls -d /home/ibv/jdurban/MinION/$sample/pass_split/pass_* | wc -l`
cp /home/ibv/jdurban/MinION/${sample}/Canu_assembly_${sample}/Canu_assembly_${sample}.unitigs.fasta $tmpnano
#cp /home/ibv/jdurban/MinION/${sample}/${sample}_collapse.fastq $tmpnano
#cp -r /home/ibv/jdurban/MinION/$sample/map/${sample}.contigs.sorted.bam* $tmpnano
cp /home/ibv/jdurban/MinION/${sample}/map/${sample}.unitigs.sorted.bam* $tmpnano

cd $tmpnano
source /home/ibv/jdurban/programas/virtualenv/myVE/bin/activate

echo $(date)
	echo "Nanopolish consensus"
#	for i in `seq 1 1 $number_of_dirs`; do 
#	cp -r /home/ibv/jdurban/MinION/$sample/pass_split/pass_${i}/ .
#	cp -r /home/ibv/jdurban/MinION/$sample/pass_allfast5 .
#	done

## Nanopolish extract ##
#nanopolish extract -q -t template pass_allfast5 -o ${sample}_collapse.fastq

## Convertir la referencia de fastq a fasta ##
#cat ${sample}_collapse.fastq | awk '{if(NR%4==1) {printf(">%s\n",substr($0,2));} else if(NR%4==2) print;}' > ${sample}_collapse.fasta

## Nanopolish ##
python /home/ibv/jdurban/programas/nanopolish/scripts/nanopolish_makerange.py Canu_assembly_${sample}.unitigs.fasta | /home/ibv/jdurban/programas/bin/parallel --results nanopolish.results -P 8 \ nanopolish variants --consensus=polished.{1}.fa -w {1} -r ${sample}_collapse.fasta -b ${sample}.unitigs.sorted.bam -g Canu_assembly_${sample}.unitigs.fasta -t 8
 
python /home/ibv/jdurban/programas/nanopolish/scripts/nanopolish_merge.py polished*.fa > ${sample}_polished_genome.fa

echo $(date) 
echo "Done"

## Assembly Stats ##
echo $(date)
echo "Assembly stats"
#mkdir stats
#quast.py -t 8 *polished_genome.fa -o ${sample}_assembly_stats
echo $(date)
echo "Done"

mv ${sample}_polished_genome.fa /home/ibv/jdurban/MinION/$sample
#mv ${sample}_collapse.fasta /home/ibv/jdurban/MinION/$sample
#mv ${sample}_assembly_stats /home/ibv/jdurban/MinION/$sample

exit

#sbatch -p q-low ~/scripts/nanopolish_consensus
