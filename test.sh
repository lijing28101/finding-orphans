#!/bin/bash
   
for database in *.db
do                                                                             
     blastp -query Glycine_max.faa -db $database/$database -out GM_$database.txt -outfmt '6 qseqid sseqid evalue'
done
