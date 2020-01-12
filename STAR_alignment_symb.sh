#!/bin/bash
#BSUB -J STAR_align
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/alignment_symb.e%J
#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/alignment_symb.e%J


# creating variables and what not
deproj='/scratch/projects/transcriptomics/ben_young/apalm_v2'

# making a list of sample names
PALMATA=`ls /scratch/projects/transcriptomics/ben_young/apalm_v2/non_aligned_fastq/ | sed 's/\(.*\)_Unmapped.out.mate1/\1/g'`
mkdir /scratch/projects/transcriptomics/ben_young/apalm_v2/aligned_symb

# the files being processed
echo "samples being aligned"
echo $PALMATA

for PALPAL in $PALMATA
do
mkdir /scratch/projects/transcriptomics/ben_young/apalm_v2/aligned_symb/${PALPAL}
echo "$PALPAL"
echo '#!/bin/bash' > /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh
echo '#BSUB -J '"$PALPAL"'' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh
echo '#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/'"$PALPAL"'_error_alignment.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh
echo '#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/'"$PALPAL"'_output_alignment.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh
echo '#BSUB -q bigmem'  >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh
echo '#BSUB -n 8' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh
echo '#BSUB -R "rusage[mem=5000]"' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh

echo '/nethome/bdy8/Ben_Xaymara_GE_project/programs/STAR \
--runThreadN 8 \
--genomeDir /scratch/projects/transcriptomics/ben_young/apalm_v2/sym_star_index/ \
--readFilesIn /scratch/projects/transcriptomics/ben_young/apalm_v2/non_aligned_fastq/'"$PALPAL"'_Unmapped.out.mate1 \
--outSAMtype BAM SortedByCoordinate \
--quantMode TranscriptomeSAM GeneCounts \
--outSAMstrandField intronMotif \
--twopassMode Basic \
--twopass1readsN -1 \
--outFileNamePrefix /scratch/projects/transcriptomics/ben_young/apalm_v2/aligned_symb/'"$PALPAL"'/'"$PALPAL"'_' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh
bsub < /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_symb_alignment.sh
done
