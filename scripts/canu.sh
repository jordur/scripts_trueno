#!/bin/sh 
#SBATCH --job-name="Canu_assembly"
#SBATCH --mem=15G
export tmpcanu=/scratch-global/$SLURM_JOB_USER

if [ "$barcode" = "" ]; then
	cp /home/ibv/jdurban/MinION/$sample/trimmed/*.fastq.gz $tmpcanu
	echo "No barcode present"
else
	case $barcode in
		"none") cp /home/ibv/jdurban/MinION/$sample/trimmed/none.fastq.gz $tmpcanu;;
		"NB01")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB01.fastq.gz $tmpcanu;;
		"NB02")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB02.fastq.gz $tmpcanu;;
		"NB03")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB03.fastq.gz $tmpcanu;;
		"NB04")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB04.fastq.gz $tmpcanu;;
		"NB05")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB05.fastq.gz $tmpcanu;;
		"NB06")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB06.fastq.gz $tmpcanu;;
		"NB07")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB07.fastq.gz $tmpcanu;;
		"NB08")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB08.fastq.gz $tmpcanu;;
		"NB09")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB09.fastq.gz $tmpcanu;;
		"NB10")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB10.fastq.gz $tmpcanu;;
		"NB11")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB11.fastq.gz $tmpcanu;;
		"NB12")  cp /home/ibv/jdurban/MinION/$sample/trimmed/NB12.fastq.gz $tmpcanu;;
	esac
fi

cd $tmpcanu

## Canu assembly ##
echo $(date)
for uniqueBC in `ls ${tmpcanu}/*.fastq.gz | xargs -n1 basename`; do
	uniqueBC=`echo "$uniqueBC" | sed "s/.fastq.gz//"`
	mkdir Canu_assembly_${sample}_${uniqueBC}

	if [ "$small" = "small" ]; then
		/home/ibv/jdurban/programas/canu/Linux-amd64/bin/canu -p Canu_assembly_${sample}_${uniqueBC} -d Canu_assembly_${sample}_${uniqueBC} corMinCoverage=0 correctedErrorRate=0.105 contigFilter="2 1000 1.0 1.0 2" genomeSize=$genome -nanopore-raw $tmpcanu/${uniqueBC}.fastq.gz
	else
		/home/ibv/jdurban/programas/canu/Linux-amd64/bin/canu -p Canu_assembly_${sample}_${uniqueBC} -d Canu_assembly_${sample}_${uniqueBC} corMinCoverage=0 correctedErrorRate=0.105 corMemory=64 genomeSize=$genome -nanopore-raw $tmpcanu/${uniqueBC}.fastq.gz
	fi
done
echo $(date)
#sbatch -p q-low -n4 --mem-per-cpu=16GB ~/scripts/canu
#sbatch -p q-low --mem=64GB ~/scripts/canu
