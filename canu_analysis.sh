#! /bin/bash
#####################################################
# Script para lanzar los siguientes trabajos:
#	- nanopolish_extract.sh
#	- porechop (trimming)
#	- canu.sh
#	- bwa_nanopore.sh
#	- nanopolish_consensus.sh
#####################################################
echo 'Description: Assembly of MinION nanopore reads'

# ---------------
# -- functions --
# ---------------

scriptname=`basename "$0"`

usage()
# Displays the script usage
{
        # Parameters:
        scriptname=$1

        echo "$scriptname is a MinION Oxford Nanopore Assembly script."
        echo "Usage:"
        echo "$scriptname -s SAMPLE -g GENOME_SIZE(k kilobp, m megabp, g gigabp) -t SMALL (optional) -pe1 IlluminaPE1 -pe2 IlluminaPE2"
        echo
        echo "* Options: *"
        echo " -s               Sample name"
        echo " -g               Estimated genome size"
	echo " -t               If \"small\" is set, contigFilter option for Canu will be added (Optional, Default: large genome)"
	echo " -b               Barcode: BC1, BC2,..,BC12,none (Optional, Default: all BCs) "
	echo " -1               Illumina PE reads 1 (Optional, SPAdes downstream)"
	echo " -2               Illumina PE reads 2 (Optional, SPAdes downstream)"
        echo
        echo "* Examples of running: *"
        echo " $scriptname -s Batrox -g 11k -t small"
	echo " $scriptname -s Ecoli -g 4.8m"
	echo " $scriptname -s Ecoli -g 4.8m /home/reads1.fq /home/reads2.fq"
	echo
        echo "* WARNING * 
               - Provide fast5 files with the following structure:
                       SAMPLE/
                         └── pass_split (IMP! Locally execute a split of pass fast5 files)
                               └──pass_[1-9]
                                   └──*.fast5
               - Reference should be named as SAMPLE_DEF.fasta
       "

exit
}


# ---------------------------------------------------
# ------- Setting input options and parameters ------
# ---------------------------------------------------

OPTERROR=65

while getopts ":s:g:t:b:pe1:pe2:" Option; do
        case $Option in
                s) sample="$OPTARG";;
                g) genome="$OPTARG";;
                t) small="$OPTARG";;
                b) barcode="$OPTARG";;
                1) pair1="$OPTARG";;
                2) pair2="$OPTARG";;
                *) echo "ERROR: Invalid option: -$OPTARG ! Call $scriptname with no parameters for help."; exit;;
        esac
done

if [ "$sample" == "" ] || [ "$genome" == "" ]; then
	echo "ERROR: Not enough parameters in call to $scriptname!!"
	usage $scriptname;
        exit $OPTERROR;
fi

export sample
export genome
export small
export barcode
export pair1
export pair2

# ------------------------------------ #
# -- Canu nanopore assembly script  -- #
# ------------------------------------ #

export exec_time=`date`
echo Script started at $exec_time

## Creem directori pels jobs ##
if [ ! -d /home/ibv/jdurban/MinION/$sample/jobs ]; then

	mkdir -p /home/ibv/jdurban/MinION/$sample/jobs
else
	echo "Ja existeix directori jobs"
fi

## NANOPOLISH EXTRACT ##
Nanopolish_extract()
{
echo "Nanopolish extract command"
jid1=$(sbatch  -p q-low -n 1 ~/scripts/nanopolish_extract2.sh)
echo $jid1 > /home/ibv/jdurban/MinION/$sample/jobs/job.txt
job=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job.txt`
}

## Porechop ##
porechop(){
echo "Porechop command"
jid2=$(sbatch -p q-low ~/scripts/porechop.sh)
echo $jid2 > /home/ibv/jdurban/MinION/$sample/jobs/job2.txt
job2=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job2.txt`
}

## CANU ##
Canu_assembly()
{
echo "Canu_assembly"
#sbatch -p q-low --dependency=afterany:$job2 ~/scripts/canu.sh
sbatch -p q-low --mem=50G ~/scripts/canu.sh
#jid3=$(sbatch -p q-low --dependency=afterany:$job2 ~/scripts/canu.sh)
#echo $jid3 > /home/ibv/jdurban/MinION/$sample/jobs/job3.txt
#job3=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job3.txt`
}

## Ejecutar BWA ##
BWA()
{
echo "BWA alignment"
sbatch -p q-low ~/scripts/bwa_nanopore.sh
jid4=$(sbatch -p q-low ~/scripts/bwa_nanopore.sh)
echo $jid4 > /home/ibv/jdurban/MinION/$sample/jobs/job4.txt
job4=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job4.txt`
}

## SPAdes ##
spades(){
echo "SPAdes with Illumina data"
	# FastQC #
		jid5=$(sbatch -p q-low --dependency=afterany:$job4 -n 6 ~/scripts/fastqc_raw.sh)
		echo $jid5 > /home/ibv/jdurban/MinION/$sample/jobs/job5.txt
		job5=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job5.txt`
	# Trimmomatic #
		jid6=$(sbatch -p q-low --dependency=afterany:$job5 -n 6 ~/scripts/trimmomatic.sh)
		echo $jid6 > /home/ibv/jdurban/MinION/$sample/jobs/job6.txt
		job6=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job6.txt`
	# Sincronitzem #
		jid7=$(sbatch -p q-low --dependency=afterany:$job6 ~/scripts/sync.sh)
		echo $jid7 > /home/ibv/jdurban/MinION/$sample/jobs/job7.txt
		job7=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job7.txt`
	# Flash #
		jid8=$(sbatch -p q-low --dependency=afterany:$job7 -n 6 ~/scripts/flash.sh)
		echo $jid8 > /home/ibv/jdurban/MinION/$sample/jobs/job8.txt
		job8=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job8.txt`
	# FastQC #
		jid9=$(sbatch -p q-low --dependency=afterany:$job8 ~/scripts/fastqc_proc.sh)
		echo $jid9 > /home/ibv/jdurban/MinION/$sample/jobs/job9.txt
		job9=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job9.txt`
	# SPAdes #
#		jid10=$(sbatch -p q-low --dependency=afterany:$job9 ~/scripts/spades.sh)
                echo $jid10 > /home/ibv/jdurban/MinION/$sample/jobs/job10.txt
                job10=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job10.txt`
}

## Nanopolish consensus ##
nanopolish_consensus()
{
echo "Nanopolish_consensus"
sbatch -p q-low ~/scripts/nanopolish_consensus.sh
jid6=$(sbatch -p q-low --dependency=afterany:$job5 ~/scripts/nanopolish_consensus.sh)
echo $jid6 > /home/ibv/jdurban/MinION/$sample/jobs/job6.txt
job6=`awk '{print $NF}' /home/ibv/jdurban/MinION/$sample/jobs/job6.txt`
}

# -----------------------------
# -- Name, version and usage --
# -----------------------------

scriptname=`basename $0`
if [ $# -eq 0 ]; then
        usage $scriptname
        exit $OPTERROR
fi

# -----------------------------------------
# ------------ main body ------------------
# -----------------------------------------

#Nanopolish_extract

## STOP ##
#porechop
Canu_assembly 

## STOP ##
#BWA
if [ "$pair1" != "" ] && [ "$pair2" != "" ]; then
	spades
else
	echo "No Illumina data provided"	
fi
#nanopolish_consensus
