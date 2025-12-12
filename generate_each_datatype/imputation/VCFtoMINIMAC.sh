### MGLF ###

out=/path/to/data/
prefix=CCDG_14151_B01_GRM_WGS_2020-08-05_chr

### minimac3 ###
seq 1 22 | xargs -I {} -P 22 bash -c 'Minimac3 --refHaps '"${out}${prefix}"'{}.filtered.shapeit2-duohmm-phased.vcf.gz --processReference --prefix '"${out}"'imputation/1KG_hg38_chr{}.MinimacFull --chr chr{}'

### minimac4 ###
seq 1 22 | xargs -I {} -P 22 bash -c 'minimac4 --update-m3vcf '"${out}"'imputation/1KG_hg38_chr{}.MinimacFull.m3vcf.gz > '"${out}"'imputation/1KG_hg38_chr{}.MinimacFull.msav'
