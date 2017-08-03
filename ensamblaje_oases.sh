#!/bin/bash
<<<<<<< HEAD
#SBATCH --job-name="Oases_rockyta"
#SBATCH --mem=80G
cp /home/ibv/jdurban/rockyta/SRR441163/results/preprocessing/out.notCombined_1.fastq /home/ibv/jdurban/rockyta/SRR441163/results/preprocessing/out.notCombined_2.fastq /home/ibv/jdurban/rockyta/SRR441163/results/preprocessing/SRR441163_singles.fastq $SLURMTMP
cd $SLURMTMP

export OMP_NUM_THREADS=4

oases_pipeline.py -m 25 -M 71 -o /home/ibv/jdurban/rockyta/SRR441163/results/assembly/oases -d "-fastq -shortPaired -strand_specific -separate out.notCombined_1.fastq out.notCombined_2.fastq -fastq -short SRR441163_singles.fastq" -p "-cov_cutoff auto -scaffolding yes"

#mv * /home/ibv/jdurban/rockyta/SRR441163/results/assembly/oases
exit 
=======
#export OMP_NUM_THREADS=2

oases_pipeline.py -m 55 -M 71 -o /home/ibv/jdurban/MALPOLON/results/150827_SND104_A_L008_GZX-25/18 -d "-fastq -shortPaired -strand_specific -separate /home/ibv/jdurban/MALPOLON/rawdata/150827_SND104_A_L008_GZX-25/out.notCombined_1.fastq /home/ibv/jdurban/MALPOLON/rawdata/150827_SND104_A_L008_GZX-25/out.notCombined_2.fastq -fastq -short /home/ibv/jdurban/MALPOLON/rawdata/150827_SND104_A_L008_GZX-25/150827_SND104_A_L008_GZX-25_singles.fastq" -p "-cov_cutoff auto -scaffolding yes"
>>>>>>> ca15b09d40a602dbf03db202f3c73e6929cc5aaf


