out=$1
tmp=$2
samples=$3
header=$4
nb_samples=$(wc -l $samples | awk '{print $1}')

seq 1 $nb_samples | xargs -I {} -P 20 bash -c '
    ID=$(sed -n "{}p" '"${samples}"') ;
    echo "${ID}" ;
    bcftools reheader -h <(cat '"${header}"' ; bcftools view -h '"${tmp}"'"${ID}"_allchr_low-pass_0.5x_imputed_ligated.vcf.gz |grep "#CHROM") -o '"${tmp}"'"${ID}"_allchr_low-pass_0.5x_imputed_ligated.fixed.vcf.gz '"${tmp}"'"${ID}"_allchr_low-pass_0.5x_imputed_ligated.vcf.gz ;
    tabix '"${tmp}"'"${ID}"_allchr_low-pass_0.5x_imputed_ligated.fixed.vcf.gz'

bcftools merge ${tmp}*_allchr_low-pass_0.5x_imputed_ligated.fixed.vcf.gz -Oz -o ${out}GeT-RM_allchr_low-pass_0.5x_imputed_ligated.merged.vcf.gz
tabix ${out}GeT-RM_allchr_low-pass_0.5x_imputed_ligated.merged.vcf.gz
