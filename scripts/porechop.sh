#!/bin/sh 
#SBATCH --job-name="porechop"
#SBATCH --mem=20G
cp /home/ibv/jdurban/MinION/$sample/${sample}_collapse.fastq $SLURMTMP
cd $SLURMTMP

## Exporto variables necessàries i python3 ##
export LD_LIBRARY_PATH=/home/ibv/jdurban/programas/gcc6.2/lib64:$LD_LIBRARY_PATH
source ~/programas/virtualenv/myVE_3/bin/activate

echo $(date)
echo "Porechop nanopore sequences"
mkdir trimmed
porechop -i ${sample}_collapse.fastq -b trimmed >& /home/ibv/jdurban/MinION/${sample}/${sample}_porechop.log
echo $(date)
echo "Done"
mv trimmed /home/ibv/jdurban/MinION/$sample/

