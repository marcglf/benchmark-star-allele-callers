### MGLF ###
### PYPGX ON 1KG ###


### FOR IMPUT DATA ###
vcf=/path/to/data/imputation/GeT-RM_allchr.gsaArray.mini4.merged.vcf.gz
assembly=GRCh38

seq 1 9 | xargs -I {} -P 9 bash -c '
    gene=$(sed -n "{}p" /files/bench_genes.txt  | tr -d '[:space:]')
    out=/output/"${gene}"_1KG_IMPUT/
    echo "$gene"
    echo "$out"
    pypgx run-chip-pipeline --force --assembly '"${assembly}"' $gene $out '"${vcf}"'
'


### FOR GENOTYPING DATA ###
vcf=/path/to/data/Genotyping/1KG_hg38_allchr_gsaArray.vcf.gz
assembly=GRCh38

seq 1 9 | xargs -I {} -P 9 bash -c '
    gene=$(sed -n "{}p" /files/bench_genes.txt | tr -d '[:space:]')
    out=/output/"${gene}"_1KG_CHIP/
    echo "$gene"
    echo "$out"
    pypgx run-chip-pipeline --force --assembly '"${assembly}"' $gene $out '"${vcf}"'
'


### FOR WGS DATA ###
vcf=/path/to/data/CCDG_14151_B01_GRM_WGS_2020-08-05_allchr.filtered.shapeit2-duohmm-phased.vcf.gz
assembly=GRCh38

seq 1 9 | xargs -I {} -P 9 bash -c '
    gene=$(sed -n "{}p" /files/bench_genes.txt | tr -d '[:space:]')
    depth=/path/to/data/depth_of_coverage/all-depth-of-coverage.zip
    control=/path/to/data/control_statistics/all-control-statistics.zip
    out=/output/"${gene}"_1KG_WGS/
    echo "$gene"
    echo "$out"
    pypgx run-ngs-pipeline --force --assembly '"${assembly}"' --control-statistics ${control} --depth-of-coverage ${depth} --variants '"${vcf}"' $gene $out
'


### FOR LOWPASS DATA ###
vcf=/path/to/data/GeT-RM_low_pass_CRAM/GeT-RM_allchr_low-pass_0.5x_imputed_ligated.merged.vcf.gz
assembly=GRCh38

seq 1 9 | xargs -I {} -P 9 bash -c '
    gene=$(sed -n "{}p" /files/bench_genes.txt  | tr -d '[:space:]')
    out=/output/"${gene}"_1KG_LOWPASS/
    echo "$gene"
    echo "$out"
    pypgx run-chip-pipeline --force --assembly '"${assembly}"' $gene $out '"${vcf}"'
'
