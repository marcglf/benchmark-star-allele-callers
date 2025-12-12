sample=$1
tmp=$2
cram_path=$3
ref_path=$4

seq 1 22 | xargs -I {} -P 22 bash -c '
sample='"${sample}"'
tmp='"${tmp}"'
cram_path='"${cram_path}"'
ref_path='"${ref_path}"'
CHR={}

samtools view -C -T ${cram_path}GRCh38_full_analysis_set_plus_decoy_hla.fa -o ${tmp}${sample}.chr${CHR}.low-pass.0.5x.cram ${cram_path}${sample}.low-pass.0.5x.cram chr${CHR}
samtools index ${tmp}${sample}.chr${CHR}.low-pass.0.5x.cram

fam_samples=$(awk -v s=${sample} '\''$2 == s {print ($3!=0&&$4!=0?$2","$3","$4:($3!=0&&$4==0?$2","$3:($3==0&&$4!=0?$2","$4:$2)))}'\'' "${ref_path}kgp3_metadata.tsv")

bcftools norm -m -any ${ref_path}CCDG_14151_B01_GRM_WGS_2020-08-05_chr${CHR}.filtered.shapeit2-duohmm-phased.vcf.gz -Ou --threads 1 |
bcftools view -m 2 -M 2 -v snps -s ^${fam_samples} --threads 1 -Ob -o ${tmp}1000GP.chr${CHR}.no${sample}.bcf
bcftools index -f ${tmp}1000GP.chr${CHR}.no${sample}.bcf --threads 1

bcftools view -G -Oz -o ${tmp}1000GP.chr${CHR}.no${sample}.sites.vcf.gz ${tmp}1000GP.chr${CHR}.no${sample}.bcf
bcftools index -f ${tmp}1000GP.chr${CHR}.no${sample}.sites.vcf.gz

GLIMPSE2_chunk_static --input  ${tmp}1000GP.chr${CHR}.no${sample}.sites.vcf.gz --region chr${CHR} --output ${tmp}chunks.chr${CHR}.no${sample}.txt --map /PROJECTS/FranceGenRef/PGx/imputation/genetic_map/GLIMPSE2_map/genetic_maps.b38/chr${CHR}.b38.gmap.gz --sequential

REF=${tmp}1000GP.chr${CHR}.no${sample}.bcf
MAP=/path/to/data/GLIMPSE2_map/genetic_maps.b38/chr${CHR}.b38.gmap.gz
while IFS="" read -r LINE || [ -n "$LINE" ];
do
  printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
  IRG=$(echo $LINE | cut -d" " -f3)
  ORG=$(echo $LINE | cut -d" " -f4)

  GLIMPSE2_split_reference_static --reference ${REF} --map ${MAP} --input-region ${IRG} --output-region ${ORG} --output ${tmp}split/1000GP.chr${CHR}.no${sample}
done < ${tmp}chunks.chr${CHR}.no${sample}.txt


REF=${tmp}split/1000GP.chr${CHR}.no${sample}
BAM=${tmp}${sample}.chr${CHR}.low-pass.0.5x.cram

while IFS="" read -r LINE || [ -n "$LINE" ]; 
do   
	printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
	IRG=$(echo $LINE | cut -d" " -f3)
	ORG=$(echo $LINE | cut -d" " -f4)
	chr=$(echo ${LINE} | cut -d" " -f2)
	REGS=$(echo ${IRG} | cut -d":" -f 2 | cut -d"-" -f1)
	REGE=$(echo ${IRG} | cut -d":" -f 2 | cut -d"-" -f2)
	OUT=${tmp}${sample}_imputed
	GLIMPSE2_phase_static --bam-file ${BAM} --ind-name ${sample} --reference ${REF}_${chr}_${REGS}_${REGE}.bin --output ${OUT}_${chr}_${REGS}_${REGE}.bcf
done < ${tmp}chunks.chr${CHR}.no${sample}.txt


LST=${tmp}list.${sample}.chr${CHR}.txt
ls -1v ${tmp}${sample}_imputed_chr${CHR}*.bcf > ${LST}

OUT=${tmp}${sample}_chr${CHR}_low-pass_0.5x_imputed_ligated.bcf
GLIMPSE2_ligate_static --input ${LST} --output $OUT

rm ${tmp}${sample}.chr${CHR}.low-pass.0.5x.*cram*
rm ${tmp}list.${sample}.chr${CHR}.txt
rm ${tmp}*chr${CHR}.no${sample}.*
rm ${tmp}split/1000GP.chr${CHR}.no${sample}_*
rm ${tmp}${sample}_imputed_chr${CHR}_*.bcf*
rm ${tmp}${sample}_imputed_chr${CHR}_*.txt.gz'


bcftools concat -o ${tmp}${sample}_allchr_low-pass_0.5x_imputed_ligated.vcf.gz -O v $(ls ${tmp}${sample}_chr*_low-pass_0.5x_imputed_ligated.bcf | sort -V) -W

rm ${tmp}${sample}_chr*_low-pass_0.5x_imputed_ligated.bcf*
