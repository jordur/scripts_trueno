#!/bin/sh 
#SBATCH --job-name="Nanopolish"
#SBATCH --mem=16G
if [ -d /home/ibv/jdurban/MinION/$sample/pass_split ]; then
#	echo "Existeix el fitxer!"
	cd $SLURMTMP
	echo $(date)
	echo "Nanopolish extract command"
############################################################################
# Executar en el cas de tindre tots els fast5 en un únic un directori pass #
############################################################################

#	cp -r /home/ibv/jdurban/MinION/$sample/pass_split/pass_1 $SLURMTMP
#	nanopolish extract -q -t template pass_1 -o ${sample}_collapse.fastq

#####################################################################################
# Versió a millorar en cas de tindre els fitxers fast5 en diferents carpetes pass_* #
#####################################################################################

	export number_of_dirs=`ls -d /home/ibv/jdurban/MinION/$sample/pass_split/pass_* | wc -l`
		for i in `seq 1 1 $number_of_dirs`; do
			echo "#!/bin/sh" > /home/ibv/jdurban/MinION/$sample/jobs/nano_job_${i}.sh
			echo "#SBATCH --job-name=Nano_${i}" >> /home/ibv/jdurban/MinION/$sample/jobs/nano_job_${i}.sh
			echo "#SBATCH --mem=16G" >> /home/ibv/jdurban/MinION/$sample/jobs/nano_job_${i}.sh
			echo "cp -r /home/ibv/jdurban/MinION/$sample/pass_split/pass_${i} \$SLURMTMP" >> /home/ibv/jdurban/MinION/$sample/jobs/nano_job_${i}.sh
			echo "cd \$SLURMTMP" >> /home/ibv/jdurban/MinION/$sample/jobs/nano_job_${i}.sh
			echo "nanopolish extract -q -t template pass_${i} -o ${sample}_${i}_DEF.fastq" >> /home/ibv/jdurban/MinION/$sample/jobs/nano_job_${i}.sh
			echo "cat ${sample}_${i}_DEF.fastq >> /home/ibv/jdurban/MinION/$sample/${sample}_collapse.fastq" >> /home/ibv/jdurban/MinION/$sample/jobs/nano_job_${i}.sh
		done
	cd /home/ibv/jdurban/MinION/$sample/jobs
	for i in `seq 1 1 $number_of_dirs`; do
		jid11=$(sbatch  -p q-low -n 1 nano_job_${i}.sh)
		echo $jid11 > /home/ibv/jdurban/MinION/$sample/jobs/job11.txt
	done
	cd $SLURMTMP
        job11=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job11.txt`
else

	echo "fast5 files do not exist" > /home/ibv/jdurban/MinION/$sample/${sample}_extract.log
fi
echo $(date)
echo "Done"
exit

#sbatch -p q-low -n 1 ~/scripts/nanopolish_extract
