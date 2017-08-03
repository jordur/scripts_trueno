<<<<<<< HEAD
#!/bin/bash
#SBATCH --job-name="trinity"
#SBATCH --mem=120G
cp /home/ibv/jdurban/rockyta/SRR441163/rawdata/Trinity_R1.fq.tar.gz /home/ibv/jdurban/rockyta/SRR441163/rawdata/Trinity_R2.fq.tar.gz $SLURMTMP;
cd $SLURMTMP

Trinity --seqType fq --max_memory 100G --left Trinity_R1.fq.tar.gz --right Trinity_R2.fq.tar.gz --SS_lib_type FR --output /home/ibv/jdurban/rockyta/SRR441163/results/assembly/Trinity --CPU 5 --min_contig_length 100 --full_cleanup > /home/ibv/jdurban/rockyta/SRR441163/results/Trinityrun.log --verbose

exit
=======
Trinity --seqType fq --max_memory 100G --left /home/ibv/jdurban/MALPOLON/rawdata/150827_SND104_A_L008_GZX-25/Trinity_R1.fq.gz --right /home/ibv/jdurban/MALPOLON/rawdata/150827_SND104_A_L008_GZX-25/Trinity_R2.fq.gz --SS_lib_type RF --output /home/ibv/jdurban/MALPOLON/results/150827_SND104_A_L008_GZX-25/Trinity --CPU 5 --min_contig_length 100 --full_cleanup > /home/ibv/jdurban/MALPOLON/results/150827_SND104_A_L008_GZX-25/Trinityrun.log 2>/home/ibv/jdurban/MALPOLON/results/150827_SND104_A_L008_GZX-25/Trinity_error.txt --verbose
>>>>>>> ca15b09d40a602dbf03db202f3c73e6929cc5aaf

