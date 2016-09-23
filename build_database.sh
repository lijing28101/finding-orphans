#!/bin/bash

# import BLAST module
module load LAS/ncbi-blast/2.4.0+

for protein in *.$1
do
   mkdir $protein.db
   cp $protein $protein.db
   cd $protein.db
   makeblastdb -in $protein -title $protein.db -dbtype prot -out $protein.db -parse_seqids
   cd ..
done
