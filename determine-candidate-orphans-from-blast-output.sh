#!/bin/bash

# Find genes that have e-values below 1e-20
awk '$3 < 1e-20' *blast.tab | cut -f1 | uniq | sort -u > non-orphans_1e^-20.txt

# Find genes that have e-values below 1e-3
awk '$3 < 1e-3' *blast.tab | cut -f1 | uniq | sort -u > non-orphans_1e^-3.txt

# cat complete list of genes and list of non-orphans together, sort them, get the elements that appear only once (using uniq, see the man page)
#list the name of complete genes
awk '$3' Glycine_max.faa | cut -f1 | uniq | sort -u > complete_genes.txt
awk '{print $1}' complete_genes.txt | sed 's/>//g' > complete_genes_1.txt
#combine complete genes and non-orphans gene
cat complete_genes_1.txt non-orphans_1e^-20.txt > 1e^-20.txt
cat complete_genes_1.txt non-orphans_1e^-3.txt > 1e^-3.txt

# This will give you two files, one with orphans with max evalues above 1e-20, one with max evalues above 1e-3
sort 1e^-20.txt | uniq -u > orphans_1e^-20.txt
sort 1e^-3.txt | uniq -u > orphans_1e^-3.txt

