#!/bin/bash
#BSUB -J salmon_mran
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/salmon/salmon_mran.e%J
#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/salmon/salmon_mran.o%J

## Making no trna file gff3 for everything (done in alignment step)
#awk '$3 != "tRNA" {print $0}' < /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_genome/Acerv_assembly_v1.0_200415.gff3 > /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_genome/Acerv_assembly_NO_tRNA_v1.0.gff3


# making the mran file from the genome and gtf3 file
/nethome/bdy8/Ben_Xaymara_GE_project/programs/gffread-0.9.12/gffread \
-w /scratch/projects/transcriptomics/ben_young/references/Apalm_assembly/Apalm_assembly/Acer_gffread_for_salmon.fasta \
-g /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_genome/Acerv_assembly_v1.0_171209.fasta \
/scratch/projects/transcriptomics/ben_young/apalm_v2/acer_genome/Acerv_assembly_NO_tRNA_v1.0.gff3
