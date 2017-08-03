#! /bin/bash
#SBATCH --job-name="spades1"
#SBATCH --mem="50G"

export spadesdir=/scratch-global/$SLURM_JOB_USER
	
	cd $spadesdir
	mkdir Bjararaca_NB01_spades

/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 NB01_notCombined_2.fastq --pe1-2 NB01_notCombined_1.fastq --pe1-s NB01_singles.fastq --nanopore Canu_assembly_Bjararaca_NB01.contigs.fasta -o Bjararaca_NB01_spades

cp -r Bjararaca_NB01_spades  /home/ibv/jdurban/MinION/Bjararaca
exit
