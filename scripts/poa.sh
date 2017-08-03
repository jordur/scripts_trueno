#!/bin/sh 
#SBATCH --job-name="POA"
#SBATCH --mem=100G


cp /home/ibv/jdurban/MinION/Bjararaca/vector_reads_region_nodup.fasta $SLURMTMP

cd $SLURMTMP

/home/ibv/jdurban/programas/poaV2/poa -read_fasta vector_reads_region_nodup.fasta -do_global /home/ibv/jdurban/programas/poaV2/blosum80.mat

cp -r * /home/ibv/jdurban/MinION/Bjararaca
exit

