#!/bin/bash

#SBATCH -N 1 
#SBATCH -n 1 
#SBATCH -w cn-6 

gatk SplitNCigarReads -R /mnt/users/tikn/seqdata1/bovine/reference/UMD3.1/umd3.1_rna-seq.fa \
	-I s1Aligned.out.cig.sam.test_RG.bam \
	-o s1.cig.split.rg.testbam \
	-rf ReassignOneMappingQuality -RMQF 255 -RMQT 60 \
	-U ALLOW_N_CIGAR_READS
