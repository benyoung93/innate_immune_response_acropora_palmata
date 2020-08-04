#!/bin/bash
#BSUB -J STAR_index
#BSUB -q bigmem
#BSUB -P transcriptomics
#BSUB -n 8
#BSUB -R "rusage[mem=4000]"
#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/STAR/star_index/STARindex.e%J
#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/STAR/star_index/STARindex.o%J

## removing the tRNA lines from the gff3 file
awk '$3 != "tRNA" {print $0}' < /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_genome/Acerv_assembly_v1.0_200415.gff3 > /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_genome/Acerv_assembly_NO_tRNA_v1.0.gff3


/nethome/bdy8/Ben_Xaymara_GE_project/programs/STAR \
--runThreadN 8 \
--runMode genomeGenerate \
--genomeDir /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/star_index/ \
--genomeFastaFiles /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_genome/Acerv_assembly_v1.0_171209.fasta \
--sjdbGTFfile /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_genome/Acerv_assembly_NO_tRNA_v1.0.gff3 \
--sjdbOverhang 100 \
--sjdbGTFtagExonParentTranscript Parent


########### MAKE SURE TO GET RID OF tRNA FROM THE GFF FILE
