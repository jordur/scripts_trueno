#! /bin/bash
#SBATCH --job-name="Prinseq"
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${pair1} $SLURMTMP
cp /home/ibv/jdurban/MinION/${sample}/Illumina/${pair2} $SLURMTMP
cd $SLURMTMP
echo $(date)

prinseq-lite.pl -fastq ${pair1} -trim_left 10 -trim_to_len 180 -min_qual_mean 30 -out_format 3 -out_good ${pair1}_good -out_bad ${pair1}_bad -qual_noscale -log prinseq_pre_${pair1}.log

prinseq-lite.pl -fastq ${pair2}  -trim_left 10 -trim_to_len 180 -min_qual_mean 30 -out_format 3 -out_good ${pair2}_good -out_bad ${pair2}_bad -qual_noscale -log prinseq_pre_${pair2}.log
 

echo $(date)
mv *_good.fastq /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed
mv *_bad.fastq /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed
mv *.log /home/ibv/jdurban/MinION/${sample}/Illumina/trimmed/logs
exit


