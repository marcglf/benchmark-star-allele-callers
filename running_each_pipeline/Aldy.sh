### MGLF ###

### RUN ALDY ON 1KG ###

for link in $(cat /file/1KG_cram_list.txt); do 
    ID=$(echo $link | awk -F'[/.]' '{print $12}')
    if [[ -e "/output/aldy_out/$ID.aldy.wgs.simple.txt" ]];then
        echo "Sample already done"
    else
        echo downloading $link
        wget $link
        echo running aldy for $ID
        aldy genotype -p wgs --simple -o /output/aldy_out/$ID.aldy.wgs.simple.txt -s cbc $ID.final.cram
        rm $ID.final.cram
        echo $ID.final.cram successfully deleted
    fi
done
