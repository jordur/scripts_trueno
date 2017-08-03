#!/bin/sh 
#SBATCH --job-name="Canu_assembly"
#SBATCH --mem=15G
export tmpcanu=/scratch-global/$SLURM_JOB_USER

cd $tmpcanu

## Canu assembly ##
echo $(date)
	mkdir Canu_assembly_Echis_svmp

#		/home/ibv/jdurban/programas/canu/Linux-amd64/bin/canu -p Canu_assembly_Echis_svmp -d Canu_assembly_Echis_svmp corMinCoverage=0 correctedErrorRate=0.105 contigFilter="2 1000 1.0 1.0 2" genomeSize=300k -nanopore-raw $tmpcanu/Echis_svmp.fasta.gz
		/home/ibv/jdurban/programas/canu/Linux-amd64/bin/canu -p Canu_assembly_Echis_svmp -d Canu_assembly_Echis_svmp corMinCoverage=0 correctedErrorRate=0.105 corMemory=64 genomeSize=300k -nanopore-raw $tmpcanu/Echis_svmp.fasta.gz
echo $(date)
#sbatch -p q-low -n4 --mem-per-cpu=16GB ~/scripts/canu
#sbatch -p q-low --mem=64GB ~/scripts/canu
