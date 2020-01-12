#!/bin/bash
#BSUB -J salmon_quant
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/STAR_quant.e%J
#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/STAR_quant.o%J


# making a list of sample names WITHOUT TRIMMED IN THEM (i.e. it saves numbers 1-69, not 1_trimmed to 69_trimmed :) )
PALMATA=`ls /scratch/projects/transcriptomics/ben_young/apalm_v2/trimmed_files/ | sed 's/\(.*\)_trimmed.fastq/\1/g'`

for PALPAL in $PALMATA
do
echo "$PALPAL"
echo '#!/bin/bash' > /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job
echo '#BSUB -J '"${PALPAL}"'' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job
echo '#BSUB -q general' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job
echo '#BSUB -P transcriptomics' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job
echo '#BSUB -e /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/'"$PALPAL"'_error_salmon.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job
echo '#BSUB -o /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/error_and_outputs/'"$PALPAL"'_output_salmon.txt' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job

echo 'echo "This is the sample being quantified -'"${PALPAL}"'"' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job
echo '/nethome/bdy8/Ben_Xaymara_GE_project/programs/salmon-0.10.0_linux_x86_64/bin/salmon \
quant \
-t /scratch/projects/transcriptomics/ben_young/apalm_v2/cladeA_genome/kb8_assembly.fasta \
-l SR \
-a /scratch/projects/transcriptomics/ben_young/apalm_v2/aligned_symb/'"$PALPAL"'/'"$PALPAL"'_Aligned.sortedByCoord.out.bam \
-o /scratch/projects/transcriptomics/ben_young/apalm_v2/salmon_quant/'"${PALPAL}"'_salmon' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job

echo 'echo "Sample '"${PALPAL}"' has been quantified and saved"' >> /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job

bsub < /scratch/projects/transcriptomics/ben_young/apalm_v2/scripts/salmon_scripts/"$PALPAL"_salmon_quant.job
done
