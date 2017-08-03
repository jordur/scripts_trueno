#!/bin/bash
#SBATCH --job-name="Oases_Tv1"
#SBATCH --mem=100G
cp /home/ibv/jdurban/Dany/Tv_1/Tv_1_2-paired_prinseq_good__vWo.fastq_pairs_R2.fastq /home/ibv/jdurban/Dany/Tv_1/Tv_1_1-paired_prinseq_good_Rr78.fastq_pairs_R1.fastq /home/ibv/jdurban/Dany/Tv_1/Tv_singles_collapse.fasta $SLURMTMP
cd $SLURMTMP
export OMP_NUM_THREADS=5

oases_pipeline.py -m 25 -M 71 -o /home/ibv/jdurban/Dany/Oases/Tv_1 -d "-fastq -shortPaired -strand_specific -separate Tv_1_1-paired_prinseq_good_Rr78.fastq_pairs_R1.fastq Tv_1_2-paired_prinseq_good__vWo.fastq_pairs_R2.fastq -fasta -short Tv_singles_collapse.fasta" -p "-cov_cutoff auto -scaffolding yes"
mv * $SLURM_SUBMIT_DIR
exit

