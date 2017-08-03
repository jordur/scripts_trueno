#! /bin/bash
#SBATCH --job-name="spades"
#SBATCH --mem="50G"

cp /home/ibv/jdurban/MinION/Bjararaca_Bjararaca_3_unmapped_novector/Illumina/trimmed/*notCombined_1.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/Bjararaca_Bjararaca_3_unmapped_novector/Illumina/trimmed/*notCombined_2.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/Bjararaca_Bjararaca_3_unmapped_novector/Illumina/trimmed/*.singles.fastq $SLURMTMP
cp /home/ibv/jdurban/MinION/Bjararaca_Bjararaca_3_unmapped_novector/trimmed/Bjararaca_3_unmapped_novector.fasta $SLURMTMP

cd $SLURMTMP
mkdir Bjararaca_spades_raw
/home/ibv/jdurban/programas/SPAdes-3.10.1-Linux/bin/spades.py --pe1-1 Bac1High_S11_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe1-2 Bac1High_S11_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe1-s Bac1High.singles.fastq --pe1-rf --pe2-1 Bac2High_S12_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe2-2 Bac2High_S12_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe2-s Bac2High.singles.fastq --pe2-rf --pe3-1 Bac3High_S13_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe3-2 Bac3High_S13_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe3-s Bac3High_S13.singles.fastq --pe3-rf --pe4-1 Bac4High_S14_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe4-2 Bac4High_S14_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe4-s Bac4High_S14.singles.fastq --pe4-rf --pe5-1 Bac5High_S15_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe5-2 Bac5High_S15_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe5-s Bac5High_S15.singles.fastq --pe5-rf --pe6-1 Bac6High_S16_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe6-2 Bac6High_S16_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe6-s Bac6High_S16.singles.fastq --pe6-rf --pe7-1 Bac7High_S17_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe7-2 Bac7High_S17_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe7-s Bac7High_S17.singles.fastq --pe7-rf --pe8-1 Bac8_S8_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_1.fastq --pe8-2 Bac8_S8_L001_R1_001.fastq.gz_good.fastq_clean.fastq-common.fq.notCombined_2.fastq --pe8-s Bac8_S8.singles.fastq --pe8-rf --nanopore Bjararaca_3_unmapped_novector.fasta -o Bjararaca_spades_raw

cp -r Bjararaca_spades_raw /home/ibv/jdurban/MinION/Bjararaca_Bjararaca_3_unmapped_novector/
exit
