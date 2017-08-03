#! /bin/bash
#SBATCH --job-name="spades5"
#SBATCH --mem="50G"

export spadesdir=/scratch-global/$SLURM_JOB_USER
	
	cd $spadesdir
	mkdir Bjararaca_NB05_spades

/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 NB03_notCombined_2.fastq --pe1-2 NB03_notCombined_1.fastq --pe1-s NB03_singles.fastq --nanopore Canu_assembly_Bjararaca_NB05.contigs.fasta --mp1-1 23D5_MatePair_A_R1.fastq --mp1-2 23D5_MatePair_A_R2.fastq -o Bjararaca_NB05_spades

cp -r Bjararaca_NB05_spades  /home/ibv/jdurban/MinION/Bjararaca
exit
