#! /bin/bash
#SBATCH --job-name="spades4"
#SBATCH --mem="50G"

export spadesdir=/scratch-global/$SLURM_JOB_USER
	
	cd $spadesdir
	mkdir Bjararaca_NB04_spades

/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 NB05_notCombined_2.fastq --pe1-2 NB05_notCombined_1.fastq --pe1-s NB05_singles.fastq --nanopore Canu_assembly_Bjararaca_NB04.contigs.fasta --mp1-1 27H1_MatePair_A_R1.fastq --mp1-2 27H1_MatePair_A_R2.fastq -o Bjararaca_NB04_spades

cp -r Bjararaca_NB04_spades  /home/ibv/jdurban/MinION/Bjararaca
exit
