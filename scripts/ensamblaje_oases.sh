#!/bin/bash
#SBATCH --job-name="Oases_rockyta"
#SBATCH --mem=80G
cp /home/ibv/jdurban/rockyta/SRR441163/results/preprocessing/out.notCombined_1.fastq /home/ibv/jdurban/rockyta/SRR441163/results/preprocessing/out.notCombined_2.fastq /home/ibv/jdurban/rockyta/SRR441163/results/preprocessing/SRR441163_singles.fastq $SLURMTMP
cd $SLURMTMP

export OMP_NUM_THREADS=4

oases_pipeline.py -m 25 -M 71 -o /home/ibv/jdurban/rockyta/SRR441163/results/assembly/oases -d "-fastq -shortPaired -strand_specific -separate out.notCombined_1.fastq out.notCombined_2.fastq -fastq -short SRR441163_singles.fastq" -p "-cov_cutoff auto -scaffolding yes"

#mv * /home/ibv/jdurban/rockyta/SRR441163/results/assembly/oases
exit 


