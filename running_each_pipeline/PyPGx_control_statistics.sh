#!/bin/bash

# filename
fichier="/file/1KG_cram_list.txt"

# read each line
while IFS= read -r ligne; do
    echo "Ligne : $ligne"
    ID=$(echo "$ligne" | sed 's|.*/||; s|\..*||')
    pypgx compute-control-statistics RYR1 1KG-control-statistics_$ID.zip $ligne --assembly GRCh38
done < "$fichier"
