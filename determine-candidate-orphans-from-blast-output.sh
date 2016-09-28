#!/bin/bash

set -u

focal_seqs=Glycine_max.faa

# List of non-orphans at the BLAST e-value < 1e-20 threshold
non_orphans_1e20=non-orphans_1e-20.txt

# List of non-orphans at the BLAST e-value < 1e-3 threshold
non_orphans_1e3=non-orphans_1e-3.txt

# List of orphans at the BLAST e-value < 1e-20 threshold
orphans_1e20=orphans_1e-20.txt

# List of orphans at the BLAST e-value < 1e-3 threshold
orphans_1e3=orphans_1e-3.txt

blast_sets=*blast.tab


# ===================================================================
# --- List non-orphans

# Find genes that have e-values below 1e-20
awk 'NR > 1 && $3 < 1e-20' $blast_sets |
    cut -f1 | uniq | sort -u > $non_orphans_1e20

# Find genes that have e-values below 1e-3
awk 'NR > 1 && $3 < 1e-3' $blast_sets |
    cut -f1 | uniq | sort -u > $non_orphans_1e3

# -------------------------------------------------------------------



# ===================================================================
# --- All genes

# This won't work, if you want to extract the ids from the fasta file (which is
# a good idea), you can do it with a single sed command. Remember to test your
# code as you go. Try working with the data interactively in the shell.

# awk '$3' Glycine_max.faa |
#     cut -f1 | uniq | sort -u > complete_genes.txt
#
# awk '{print $1}' complete_genes.txt |
#     sed 's/>//g' > complete_genes_1.txt

sed -n 's/>\([^ ]\+\).*/\1/p' $focal_seqs > complete_genes.txt

# -------------------------------------------------------------------



# ===================================================================
# --- Get orphans
# cat complete list of genes and list of non-orphans together, sort them, get
# the elements that appear only once (using uniq, see the man page) list the
# name of complete genes

# NOTES:

# What you have is good and will get the correct result. There are just a few
# things I would do differently. First, try to avoid temporary files by piping.

# # combine complete genes and non-orphans gene
# cat complete_genes_1.txt non-orphans_1e^-20.txt > 1e^-20.txt
# cat complete_genes_1.txt non-orphans_1e^-3.txt > 1e^-3.txt
#
# # This will give you two files, one with orphans with max evalues above 1e-20,
# # one with max evalues above 1e-3
# sort 1e^-20.txt | uniq -u > orphans_1e^-20.txt
#
# sort 1e^-3.txt | uniq -u > orphans_1e^-3.txt

cat complete_genes_1.txt $non_orphans_1e20 | sort | uniq -u > $orphans_1e20

cat complete_genes_1.txt $non_orphans_1e3 | sort | uniq -u > $orphans_1e3

# -------------------------------------------------------------------
