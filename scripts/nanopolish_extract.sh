#!/bin/sh 
#SBATCH --job-name="Extract"
#SBATCH --mem=20G

dir=`pwd`
if [ -d $dir/fast5 ]; then
	cp -r /home/ibv/jdurban/MinION/$sample/fast5 $SLURMTMP
	cd $SLURMTMP
	echo $(date)
	nanopolish extract -t template fast5/pass -o ${sample}_DEF.fasta 
	mv ${sample}_DEF.fasta /home/ibv/jdurban/MinION/$sample
	cp /home/ibv/jdurban/MinION/$sample/${sample}_DEF.fasta $SLURMTMP
else
	echo "fast5 files do not exist" > /home/ibv/jdurban/MinION/$sample/${sample}_extract.log
fi
echo $(date)
exit

#sbatch -p q-low -n 1 ~/scripts/nanopolish_extract
