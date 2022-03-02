# Innate Immune Response of *Acropora palmata*
Analysis scripts for the transcriptomic disease response of *Acropora palmata*.  
Publication - https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0228514. 
*Acropora palmata* & *Acropora cervicornis* genomes - http://baumslab.org/research/data/  

## *Acropora palmata* Pipeline  
### Pre-processing Pipeline (Unix)
1. Trimming - Trimmomatic    
- TRIMMOMATIC_trimming_apal.sh  
2. Alignment - STAR   
- STAR_index_apal.sh  
- STAR_alignment_apal.sh  
3. Quantification - Salmon  
- SALMON_quant_apal.sh  

### Analysis Pipeline (r and RStudio)




File names are PROGRAM_process_organism (e.g. STAR_alignment_apal)

Order of Analysis \
TRIMMOMATIC_trimming_apal.sh \
STAR_index_apal.sh \
STAR_alignment_apal.sh \
SALMON_quant_apal.sh \
STAR_alignment_symb.sh \
SALMON_quant_symb.sh



ALIB scripts are for the reannotation of Libro & Vollmer 2013. Project number to access raw reads is in manuscript.
