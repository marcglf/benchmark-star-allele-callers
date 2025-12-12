
##### LOOM FULL PIPELINE #####

### CONFIG ###
path=/path/to/data/Genotyping/
out=/path/to/data/imputation/
tmp=/bigtmp/
minimac_in=/path/to/data/imputation/
samples=/file/get-rm_samples.txt
header=/file/header_imput.txt

### MAIN SCRIPT ###

./All_1KG_imputation.sh $path $out $tmp $minimac_in $samples
./reheader.sh $path $out $tmp $minimac_in $samples $header
