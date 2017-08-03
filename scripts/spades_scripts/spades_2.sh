#! /bin/bash
#SBATCH --job-name="spades2"
#SBATCH --mem="50G"

export spadesdir=/scratch-global/$SLURM_JOB_USER
	
	cd $spadesdir
	mkdir Bjararaca_NB02_spades

/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 NB04_notCombined_2.fastq --pe1-2 NB04_notCombined_1.fastq --pe1-s NB04_singles.fastq --nanopore Canu_assembly_Bjararaca_NB02.contigs.fasta -o Bjararaca_NB02_spades

cp -r Bjararaca_NB02_spades  /home/ibv/jdurban/MinION/Bjararaca
exit
