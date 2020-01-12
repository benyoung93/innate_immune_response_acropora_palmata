#!/bin/bash
#BSUB -J STAR_align
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/alignment.e%J
#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/alignment.e%J

# making a list of sample names
PALMATA=`ls /scratch/projects/transcriptomics/ben_young/apalm_v2/trimmed_files/ | sed 's/\(.*\)_trimmed.fastq/\1/g'`

# the files being processed
echo "samples being aligned"
echo $PALMATA

for PALPAL in $PALMATA
do
mkdir /scratch/projects/transcriptomics/ben_young/apalm_v2/aligned_apal/${PALPAL}
echo "$PALPAL"
echo '#!/bin/bash' > /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh
echo '#BSUB -J '"$PALPAL"'' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh
echo '#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/'"$PALPAL"'_error_alignment.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh
echo '#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/'"$PALPAL"'_output_alignment.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh
echo '#BSUB -q bigmem'  >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh
echo '#BSUB -n 8' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh
echo '#BSUB -R "rusage[mem=5000]"' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh

echo '/nethome/bdy8/Ben_Xaymara_GE_project/programs/STAR \
--runThreadN 8 \
--genomeDir /scratch/projects/transcriptomics/ben_young/apalm_v2/star_index/ \
--readFilesIn /scratch/projects/transcriptomics/ben_young/apalm_v2/trimmed_files/'"$PALPAL"'_trimmed.fastq \
--outSAMtype BAM SortedByCoordinate \
--quantMode TranscriptomeSAM GeneCounts \
--outSAMstrandField intronMotif \
--twopassMode Basic \
--twopass1readsN -1 \
--outFileNamePrefix /scratch/projects/transcriptomics/ben_young/apalm_v2/aligned_apal/'"$PALPAL"'/'"$PALPAL"'_' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh #for alignment to symb
bsub < /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/star_scripts/"$PALPAL"_alignment.sh
done
