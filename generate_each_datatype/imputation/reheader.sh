path=$1
out=$2
tmp=$3
minimac_in=$4
samples=$5
header=$6
nb_samples=$(wc -l $samples | awk '{print $1}')

seq 1 $nb_samples | xargs -I {} -P 30 bash -c '
    ID=$(sed -n "{}p" '"${samples}"') ;
    echo "${ID}" ;
    bcftools reheader -h <(cat '"${header}"' ; bcftools view -h '"${tmp}"'"${ID}"_allchr.gsaArray.mini4.vcf.gz |grep "#CHROM") -o '"${tmp}"'"${ID}"_allchr.gsaArray.mini4.fixed.vcf.gz '"${tmp}"'"${ID}"_allchr.gsaArray.mini4.vcf.gz ;
    tabix '"${tmp}"'"${ID}"_allchr.gsaArray.mini4.fixed.vcf.gz ;
    rm '"${tmp}"'"${ID}"_allchr.gsaArray.mini4.vcf.gz* '

bcftools merge ${tmp}*_allchr.gsaArray.mini4.fixed.vcf.gz -Oz -o ${out}GeT-RM_allchr.gsaArray.mini4.merged.vcf.gz
tabix ${out}GeT-RM_allchr.gsaArray.mini4.merged.vcf.gz

rm ${tmp}*_allchr.gsaArray.mini4.fixed.vcf.gz*
