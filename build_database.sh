#!/bin/bash

for protein in *.$1
do
   mkdir $protein.db
   cp $protein $protein.db
   cd $protein.db
   makeblastdb -in $protein -title $protein.db -dbtype prot -out $protein.db -parse_seqids
   cd ..
done
