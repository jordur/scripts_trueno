#!/bin/bash
#SBATCH --job-name="trin_dany"
#SBATCH --mem=100G

cp /home/ibv/jdurban/Dany/Cc_1_1-paired_prinseq_good_4rE9.fastq_pairs_R1.fastq /home/ibv/jdurban/Dany/Cc_1_2-paired_prinseq_good_lG44.fastq_pairs_R2.fastq $TMPDIR
cd $TMPDIR

Trinity --seqType fq --max_memory 100G --left Cc_1_1-paired_prinseq_good_4rE9.fastq_pairs_R1.fastq --right Cc_1_2-paired_prinseq_good_lG44.fastq_pairs_R2.fastq --SS_lib_type RF --output /home/ibv/jdurban/Dany/Trinity/ --CPU 6 --min_contig_length 100 --full_cleanup > /home/ibv/jdurban/Dany/Trinity/Trinityrun.log 2>/home/ibv/jdurban/Dany/Trinity/Trinity_error.txt --verbose
mv * $SLURM_SUBMIT_DIR
exit
