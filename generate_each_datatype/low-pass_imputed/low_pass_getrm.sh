### Marc GLF ###
### low-pass on 1KG | GeT-RM sample (0.5x) ###

samples="/path/to/data/GeT-RM_low_pass_CRAM/get-rm_samples.txt"
nb_samples=$(wc -l $samples | awk '{print $1}')
tmp="/bigtmp/"
cram_path="/path/to/data/GeT-RM_low_pass_CRAM/"
ref_path="/path/to/data/"


seq 1 $nb_samples | xargs -I {} -P 11 bash -c '
    ID=$(sed -n '{}p' '"${samples}"')
    link=$(cat /path/to/data/CRAM/1KG_cram_list.txt |grep ${ID})
    echo downloading $ID
    wget $link
    samtools view -s 42.0167 -C -o ${ID}.low-pass.0.5x.cram ${ID}.final.cram
    rm ${ID}.final.cram'

mv /bigtmp/* /path/to/data/GeT-RM_low_pass_CRAM/
