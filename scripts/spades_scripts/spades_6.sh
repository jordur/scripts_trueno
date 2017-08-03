#! /bin/bash
#SBATCH --job-name="spades6"
#SBATCH --mem="50G"

export spadesdir=/scratch-global/$SLURM_JOB_USER
	
	cd $spadesdir
	mkdir Bjararaca_NB06_spades

/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 NB02_notCombined_2.fastq --pe1-2 NB02_notCombined_1.fastq --pe1-s NB02_singles.fastq --nanopore Canu_assembly_Bjararaca_NB06.contigs.fasta -o Bjararaca_NB06_spades

cp -r Bjararaca_NB06_spades  /home/ibv/jdurban/MinION/Bjararaca
exit
