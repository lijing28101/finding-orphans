#!/bin/bash

#create files for chromosome length
smof stat -q Glycine_max.fna | tee Glycine_max_length.tab
smof stat -q Glycine_soja.fna | tee Glycine_soja_length.tab

#Merge all output of summary chain into a new output
for i in *Glycine_soja
do 
     cd $i/*
     cat satsuma_summary.chained.out >> ../../merged_output.syn
     cd ../..
done

#Delete redundant words of column 4
sed 's/_Glycine/ /' merged_output.syn | awk -F ' ' '{print $1,$2,$3,$4,$6,$7,$8,$9}' > merged_new.syn

#clean redundant words on 9th column of gff file
cat Glycine_max.gff | awk '$3 == "gene"' | sed 's/Name=\([^;]*\);.*/\1/' > Glycine_max_cleaned.gff
cat Glycine_soja.gff | awk '$3 == "gene"' | sed 's/Name=\([^;]*\);.*/\1/' > Glycine_soja_cleaned.gff

#run synder search
./synder search -i Glycine_max_cleaned.gff -s merged_new.syn -q Glycine_max_length.tab | tee Glycine_max_output.txt
./synder search -r -i Glycine_soja_cleaned.gff -s merged_new.syn -t Glycine_soja_length.tab | tee Glycine_soja_output.txt
