### MGLF ###

prefix=/path/to/data/CCDG_14151_B01_GRM_WGS_2020-08-05_chr
suffix=.filtered.shapeit2-duohmm-phased.vcf.gz
out=/path/to/data/Genotyping/
marker=/file/Final_dat_success_mark.position38.bed

seq 1 22 | xargs -I {} -P 11 bash -c 'bcftools view -T '"${marker} ${prefix}"'{}'"${suffix}"' -o '"${out}"'1KG_hg38_chr{}_gsaArray.vcf.gz -W'

bcftools concat -o ${out}1KG_hg38_allchr_gsaArray.vcf.gz -O v $(ls ${out}1KG_hg38_chr*_gsaArray.vcf.gz | sort -V)
tabix ${out}1KG_hg38_allchr_gsaArray.vcf.gz
