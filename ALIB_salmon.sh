#!/bin/bash
#BSUB -J salmon_quant
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/salmon/salmon_quant.e%J
#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/salmon/salmon_quant.o%J


# making a list of sample names WITHOUT TRIMMED IN THEM (i.e. it saves numbers 1-69, not 1_trimmed to 69_trimmed :) )
PALMATA=`ls /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/trimmed_reads | sed 's/\(.*\)_trimmed.fastq/\1/g'`

for PALPAL in $PALMATA
do
echo "$PALPAL"
echo '#!/bin/bash' > /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job
echo '#BSUB -J '"${PALPAL}"'' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job
echo '#BSUB -q general' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job
echo '#BSUB -P transcriptomics' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job
echo '#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/salmon/error/'"$PALPAL"'_error_salmon.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job
echo '#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/error_output/salmon/output/'"$PALPAL"'_output_salmon.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job

echo 'echo "This is the sample being quantified -'"${PALPAL}"'"' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job
echo '/nethome/bdy8/Ben_Xaymara_GE_project/programs/salmon-0.10.0_linux_x86_64/bin/salmon \
quant \
-t /scratch/projects/transcriptomics/ben_young/references/Apalm_assembly/Apalm_assembly/Acer_gffread_for_salmon.fasta \
-l SR \
-a /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/aligned/'"$PALPAL"'/'"$PALPAL"'_Aligned.toTranscriptome.out.bam \
-o /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/salmon_quant'"${PALPAL}"'_salmon' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job

echo 'echo "Sample '"${PALPAL}"' has been quantified and saved"' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job

bsub < /scratch/projects/transcriptomics/ben_young/apalm_v2/acer_libro/scripts/salmon/"$PALPAL"_salmon_quant.job
done
