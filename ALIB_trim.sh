#!/bin/bash
#BSUB -J Trimming
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/trim/error/trimming.e%J
#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/trim/output/trimming.o%J

# creating variables and what not
deproj='/scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro'

# making a list of sample names
PALMATA=`ls ${deproj}/raw_reads | cut -f 1 -d '.'`

# the files being processed
echo "samples being trimmed"
echo $PALMATA

for PALPAL in $PALMATA
do
echo "$PALPAL"
echo '#!/bin/bash' > /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job
echo '#BSUB -q general' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job
echo '#BSUB -J '"$PALPAL"'' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job
echo '#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/trim/output/'"$PALPAL"'_error_trimming.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job
echo '#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/trim/error/'"$PALPAL"'_output_trimming.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job

echo 'module load java/1.8.0_60' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job
echo 'module load trimmomatic/0.36' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job

echo 'echo "This is the palmata sample being trimmed - '"${PALMATA}"'"' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job
echo '/share/opt/java/jdk1.8.0_60/bin/java -jar /share/apps/trimmomatic/0.36/trimmomatic-0.36.jar \
SE \
-phred33 \
-trimlog /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/trim/trim_log/'"${PALPAL}"'_trim.log \
'"${deproj}"'/raw_reads/'"${PALPAL}"'.fastq \
/scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/trimmed_reads/'"${PALPAL}"'_trimmed.fastq \
ILLUMINACLIP:/nethome/bdy8/Ben_Xaymara_GE_project/programs/trimmomatic-0.36/adapters/TruSeq3-SE.fa:2:30:10 \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job
bsub < /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/trim/"$PALPAL"_trimming.job
done
