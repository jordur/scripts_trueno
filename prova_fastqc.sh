#! /bin/bash
#SBATCH --job-name="FastQC"
#SBATCH --mem=64G
cp /home/ibv/jdurban/MinION/Ecoli/sample_1_mod.fastq $SLURMTMP
cd $SLURMTMP
echo $(date)
fastqc -t 6 sample_1_mod.fastq 
echo $(date)
mv * /home/ibv/jdurban/MinION/Ecoli/
exit

#sbatch -p q-low -n 1 ~/scripts/prova.sh
