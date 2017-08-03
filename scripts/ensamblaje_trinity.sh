#!/bin/bash
#SBATCH --job-name="trinity"
#SBATCH --mem=120G
cp /home/ibv/jdurban/rockyta/SRR441163/rawdata/Trinity_R1.fq.tar.gz /home/ibv/jdurban/rockyta/SRR441163/rawdata/Trinity_R2.fq.tar.gz $SLURMTMP;
cd $SLURMTMP

Trinity --seqType fq --max_memory 100G --left Trinity_R1.fq.tar.gz --right Trinity_R2.fq.tar.gz --SS_lib_type FR --output /home/ibv/jdurban/rockyta/SRR441163/results/assembly/Trinity --CPU 5 --min_contig_length 100 --full_cleanup > /home/ibv/jdurban/rockyta/SRR441163/results/Trinityrun.log --verbose

exit

