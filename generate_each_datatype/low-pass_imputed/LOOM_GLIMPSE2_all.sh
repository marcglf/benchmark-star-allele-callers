### LOOM LOW-PASS FULL PIPELINE ###

samples="/file/get-rm_samples.txt"
nb_samples=$(wc -l $samples | awk '{print $1}')
tmp="/bigtmp/"
cram_path="/path/to/data/GeT-RM_low_pass_CRAM/"
ref_path="/path/to/data/"
header=${cram_path}header.txt

seq 1 $nb_samples | xargs -I {} -P 1 bash -c '
    sample=$(sed -n '\''{}p'\'' '"${samples}"')
    echo ${sample}
    ./LOOM_GLIMPSE2_unit.sh ${sample} ${tmp} ${cram_path} ${ref_path}'

./LOOM_GLIMPSE2_reheader.sh $cram_path $tmp $samples $header
