#!/bin/bash

oases_pipeline.py -m 23 -M 43 -s 2 -o /home/ibv/jdurban/ANTIC/assembly_mid3 -d "-fasta -short /home/ibv/jdurban/ANTIC/mid3.fasta" -p "-cov_cutoff auto -unused_reads yes"

