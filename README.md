# Innate immune gene expression in *Acropora palmata* is consistent despite variance in yearly disease events
Analysis scripts for the transcriptomic disease response of *Acropora palmata*.  
Publication - https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0228514   
NCBI project for raw data - https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA529682  
*Acropora palmata* & *Acropora cervicornis* genomes - http://baumslab.org/research/data/  
Symbiodinium genome paper - https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0035269  
  
Scripts for identified steps are shown as  
- [script_name]  
  
## *Acropora palmata* Pipeline  
### Pre-processing Pipeline (Unix)
1. Trimming - Trimmomatic    
- TRIMMOMATIC_trimming_apal.sh  
2. Alignment - STAR   
- STAR_index_apal.sh  
- STAR_alignment_apal.sh  
3. Quantification - Salmon  
- SALMON_quant_apal.sh  
  
### Transcriptomic Analysis (r and RStudio)  
- apal_transcriptomic_analysis.  
  
This includes all steps after step 3 above. Code for figure parts are labelled in chunk headers. General pipeline is as follows.  
1. Pre analysis low gene filtering  
2. Principal component analysis  
3. Genes driving PC1 GO analysis  
3. Differential gene expression analysis for health states (Baseline, No Transmission, Transmission)  
4. GO analysis of differential expression results  
5. WGCNA analysis  
6. GO analysis of WGCNA modules  
  
## Symbiodinium Pipeline
### Pre-processing Pipeline (unix)  
1. Alignment - STAR  
- STAR_alignment_symb.sh  
2. Quantification - Salmon  
- SALMON_quant_symb.sh  
  
### Transcriptomic Analysis (r and RStudio)





ALIB scripts are for the reannotation of Libro & Vollmer 2013. Project number to access raw reads is in manuscript.
