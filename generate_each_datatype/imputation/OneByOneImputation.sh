
path=$1
out=$2
tmp=$3
minimac_in=$4
samples=$5
i=$6
ID=$(sed -n "${i}p" $samples)
echo $ID
#echo -e "${ID}_HAP_1\n${ID}_HAP_2" > ${tmp}${ID}.txt
fam_samples=$(awk -v s=${ID} '$2 == s {print ($3!=0&&$4!=0?$2" "$3" "$4:($3!=0&&$4==0?$2" "$3:($3==0&&$4!=0?$2" "$4:$2)))}' "/file/kgp3_metadata.tsv")
printf "%s\n" $fam_samples > ${tmp}${ID}_fam_samples.list
grep -v -F -f ${tmp}${ID}_fam_samples.list /file/kgp3_metadata.tsv > ${tmp}${ID}_metadata.tsv
awk -F'\t' 'NR != 1 {print $2"_HAP_1\n"$2"_HAP_2"}' ${tmp}${ID}_metadata.tsv > ${tmp}${ID}.txt

seq 1 22 | xargs -I {} -P 22 bash -c 'bcftools view -s '"${ID}"' '"${path}"'1KG_hg38_chr{}_gsaArray.vcf.gz -o '"${tmp}${ID}"'_1KG_hg38_chr{}_gsaArray.vcf.gz -W'
seq 1 22 | xargs -I {} -P 22 bash -c '
    minimac4 -O vcf -o '"${tmp}${ID}"'_chr{}.gsaArray.mini4.vcf.gz -f GT,HDS,GP --sample-ids-file '"${tmp}${ID}"'.txt '"${minimac_in}"'1KG_hg38_chr{}.MinimacFull.msav '"${tmp}${ID}"'_1KG_hg38_chr{}_gsaArray.vcf.gz;
    tabix '"${tmp}${ID}"'_chr{}.gsaArray.mini4.vcf.gz'

rm ${tmp}${ID}_1KG_hg38_chr*_gsaArray.vcf.gz*
rm ${tmp}${ID}.txt
rm ${tmp}${ID}_metadata.tsv
rm ${tmp}${ID}_fam_samples.list

bcftools concat -o ${tmp}${ID}_allchr.gsaArray.mini4.vcf.gz -O v $(ls ${tmp}${ID}_chr*.gsaArray.mini4.vcf.gz | sort -V) -W
rm ${tmp}${ID}_chr*.gsaArray.mini4.vcf.gz*

