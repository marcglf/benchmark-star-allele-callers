
##### LOOM FULL PIPELINE #####

### CONFIG ###
path=/path/to/data/Genotyping/
out=/path/to/data/imputation/
tmp=/bigtmp/mgroslafaige/1KG/
minimac_in=/path/to/data/imputation/
samples=/path/to/data/imputation/get-rm_samples.txt
header=/path/to/data/imputation/header.txt

### MAIN SCRIPT ###

./All_1KG_imputation.sh $path $out $tmp $minimac_in $samples
./reheader.sh $path $out $tmp $minimac_in $samples $header
