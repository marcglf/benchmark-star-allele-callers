
path=$1
out=$2
tmp=$3
minimac_in=$4
samples=$5
nb_samples=$(wc -l $samples | awk '{print $1}')

seq 1 $nb_samples | xargs -I {} -P 1 bash -c './OneByOneImputation.sh '"${path}"' '"${out}"' '"${tmp}"' '"${minimac_in}"' '"${samples}"' {}'

