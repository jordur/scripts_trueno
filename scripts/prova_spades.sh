#! /bin/bash
#SBATCH --job-name="SPADES"
#SBATCH --mem=64G
cp /home/ibv/jdurban/MinION/Ecoli/Ecoli_DEF.fasta $SLURMTMP
cd $SLURMTMPi
/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py -t 8 -1 <File with forward> reads -2 <File with reverse reads> -s <File with unpaired reads> --careful --nanopore Ecoli_DEF.fasta -k 21,33,55,77,99,127 -o Ecoli_assembly 
mv * /home/ibv/jdurban/MinION/Ecoli/
exit

#sbatch -p q-low -n 4 ~/scripts/prova.sh
