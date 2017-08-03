#! /bin/bash
#SBATCH --job-name="FastQC raw"
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${pair1} $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${pair2} $SLURMTMP
cd $SLURMTMP
echo $(date)
fastqc -t 6 ${pair1}
fastqc -t 6 ${pair2}
echo $(date)
mv * /home/ibv/jdurban/MinION/${sample}/Illumina
exit

#sbatch -p q-low -n 1 ~/scripts/prova.sh
