### MGLF ###
### PHARMCAT ON 1KG ###


### FOR CHIP DATA ###
pharmcat_preprocessor -vcf /path/to/data/Genotyping/1KG_hg38_allchr_gsaArray.vcf.gz -o /output/ -bf pharmcat_1KG_CHIP
java -jar /path./to/pharmcat/pharmcat-2.15.4-all.jar -vcf /output/pharmcat_1KG_CHIP.preprocessed.vcf.bgz

### FOR IMPUT DATA ###
pharmcat_preprocessor -vcf /path/to/data/imputation/GeT-RM_allchr.gsaArray.mini4.merged.vcf.gz -o /output/ -bf pharmcat_1KG_IMPUT -bgzip /path/to/bgzip
java -jar /path./to/pharmcat/pharmcat-2.15.4-all.jar -vcf /output/pharmcat_1KG_IMPUT.preprocessed.vcf.bgz

### FOR WGS DATA ###
pharmcat_preprocessor -vcf /path/to/data/pharmcat_output/WGS_phased_vcf_list.txt -o /output/ -bf pharmcat_1KG_WGS
java -jar /path./to/pharmcat/pharmcat-2.15.4-all.jar -vcf /output/pharmcat_1KG_WGS.preprocessed.vcf.bgz

### FOR LOWPASS DATA ###
pharmcat_preprocessor -vcf /path/to/data/GeT-RM_low_pass_CRAM/GeT-RM_allchr_low-pass_0.5x_imputed_ligated.merged.vcf.gz -o /output/ -bf pharmcat_1KG_GETRM_LOWPASS -bgzip /path/to/bgzip
java -jar /path./to/pharmcat/pharmcat-2.15.4-all.jar -vcf /output/pharmcat_1KG_GETRM_LOWPASS.preprocessed.vcf.bgz
