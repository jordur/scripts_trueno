#! /bin/bash
#SBATCH --job-name="spades"
#SBATCH --mem="50G"

export spadesdir=/scratch-global/$SLURM_JOB_USER
dir=/home/ibv/jdurban/MinION/Bjararaca;
for uniqueBC in `ls $dir/*.fastq | xargs -n1 basename`; do
        uniqueBC=`echo "$uniqueBC" | sed "s/_good.fastq//"`
	cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/*notCombined_1.fastq $spadesdir
	cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/*notCombined_2.fastq $spadesdir
	cp /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/*singles.fastq $spadesdir
	cp /home/ibv/jdurban/MinION/${sample}/Canu_assembly_${sample}_${uniqueBC}/Canu_assembly_${sample}_${uniqueBC}.contigs.fasta $spadesdir

	cd $spadesdir
	mkdir ${sample}_${uniqueBC}_spades
#/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 Bac1High_S11_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe1-2 Bac1High_S11_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe1-s Bac1High.singles.fastq --pe2-1 Bac2High_S12_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe2-2 Bac2High_S12_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe2-s Bac2High.singles.fastq --pe3-1 Bac3High_S13_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe3-2 Bac3High_S13_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe3-s Bac3High_S13.singles.fastq --pe4-1 Bac4High_S14_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe4-2 Bac4High_S14_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe4-s Bac4High_S14.singles.fastq --pe5-1 Bac5High_S15_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe5-2 Bac5High_S15_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe5-s Bac5High_S15.singles.fastq --pe6-1 Bac6High_S16_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe6-2 Bac6High_S16_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe6-s Bac6High_S16.singles.fastq --pe7-1 Bac7High_S17_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe7-2 Bac7High_S17_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe7-s Bac7High_S17.singles.fastq --pe8-1 Bac8_S8_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe8-2 Bac8_S8_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe8-s Bac8_S8.singles.fastq --nanopore Canu_assembly_Bjararaca_Bjararaca_3_unmapped_novector.contigs.fasta -o Bjararaca_spades

/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 ${uniqueBC}_notCombined_2.fastq --pe1-2 ${uniqueBC}_notCombined_1.fastq --pe1-s ${uniqueBC}_singles.fastq --nanopore Canu_assembly_${sample}_${uniqueBC}.contigs.fasta -o ${sample}_${uniqueBC}_spades

cp -r ${sample}_${uniqueBC}_spades  /home/ibv/jdurban/MinION/Bjararaca
done
exit
