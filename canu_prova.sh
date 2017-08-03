#!/bin/sh 
#SBATCH --job-name="Canu_prova"
export tmpcanu=/scratch-global/$SLURM_JOB_USER

cp /home/ibv/jdurban/MinION/Bjararaca/trimmed/all_unmapped.fastq.gz $tmpcanu

cd $tmpcanu

## Canu assembly ##
echo $(date)
mkdir Canu_assembly_Bjararaca

/home/ibv/jdurban/programas/canu/Linux-amd64/bin/canu -p Canu_assembly_Bjararaca -d Canu_assembly_Bjararaca corMinCoverage=0 errorRate=0.035 contigFilter="2 1000 1.0 1.0 2" genomeSize=2m -nanopore-raw $tmpcanu/all_unmapped.fastq.gz

	
echo $(date)
#sbatch -p q-low -n4 --mem-per-cpu=16GB ~/scripts/canu
#sbatch -p q-low --mem=64GB ~/scripts/canu
