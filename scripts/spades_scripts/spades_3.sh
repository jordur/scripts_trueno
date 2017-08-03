#! /bin/bash
#SBATCH --job-name="spades3"
#SBATCH --mem="50G"

export spadesdir=/scratch-global/$SLURM_JOB_USER
	
	cd $spadesdir
	mkdir Bjararaca_NB03_spades

/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 NB07_notCombined_2.fastq --pe1-2 NB07_notCombined_1.fastq --pe1-s NB07_singles.fastq --nanopore Canu_assembly_Bjararaca_NB03.contigs.fasta -o Bjararaca_NB03_spades

cp -r Bjararaca_NB03_spades  /home/ibv/jdurban/MinION/Bjararaca
exit
