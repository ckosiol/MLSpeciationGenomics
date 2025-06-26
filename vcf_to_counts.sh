#!/bin/bash

python3 ../../FastaVCFToCounts.py HLA-A_1_anc.fa HLA-A_1_p0.vcf.gz HLA-A_1_p1.vcf.gz HLA-A_1_p2.vcf.gz HLA_A_1.cf --merge --ploidy 2

