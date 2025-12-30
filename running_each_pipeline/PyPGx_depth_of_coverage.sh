#!/bin/bash

# filename
fichier="/file/1KG_cram_list.txt"

# read each line 
while IFS= read -r ligne; do
    echo "Ligne : $ligne"
    ID=$(echo "$ligne" | sed 's|.*/||; s|\..*||')
    pypgx prepare-depth-of-coverage 1KG-depth-of-coverage_$ID.zip $ligne --assembly GRCh38
done < "$fichier"
