#!/bin/bash
#BSUB -J STAR_index
#BSUB -q bigmem
#BSUB -P transcriptomics
#BSUB -n 8
#BSUB -R "rusage[mem=4000]"
#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/STARindex.e%J
#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/STARindex.o%J

########### MAKE SURE TO GET RID OF tRNA FROM THE GFF FILE
## removing the tRNA lines from the gff3 file
awk '$3 != "tRNA" {print $0}' < /scratch/projects/transcriptomics/ben_young/apalm_v2/apal_genome/v2/Apalm_assembly_v2.0_180910.gff3 > /scratch/projects/transcriptomics/ben_young/apalm_v2/apal_genome/v2/Apalm_assembly_v2.0_180910_no_tRNA.gff3

/nethome/bdy8/Ben_Xaymara_GE_project/programs/STAR \
--runThreadN 8 \
--runMode genomeGenerate \
--genomeDir /scratch/projects/transcriptomics/ben_young/apalm_v2/star_index/ \
--genomeFastaFiles /scratch/projects/transcriptomics/ben_young/apalm_v2/apal_genome/v2/Apalm_assembly_v2.0_180910.fasta \
--sjdbGTFfile /scratch/projects/transcriptomics/ben_young/apalm_v2/apal_genome/v2/Apalm_assembly_v2.0_180910_no_tRNA.gff3 \
--sjdbOverhang 100 \
--sjdbGTFtagExonParentTranscript Parent
