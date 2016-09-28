#!/usr/bin/bash

usage (){
cat << EOF
Classify orphans from blast results

Arguments:
  -f  Fasta file used as query in the blast run
  -d  Directory containing BLAST tabular output for each subject
      One file for each run of the query against each related genome.
  -x  Blast file extenstion (default: 'blast.tab')
  -s  Threshold e-value for orphan classification (default: 1e-3)
  -c  Column which contains query ids (qseqid position in outfmt string)
  -h  Print this help message and exit
EOF
    exit 0
}

# print help with no arguments
[[ $# -eq 0 ]] && usage

focal_seqs=
blast_dir=
blast_ext=tab
score=
idcol=3
while getopts "hfdxsc:" opt; do
    case $opt in
        h)
            usage ;;
        f) 
            focal_seqs=$OPTARG ;;
        d)
            blast_dir=$OPTARG ;;
        x) 
            blast_ext=$OPTARG ;;
        s) 
            score=$OPTARG ;;
        c) 
            idcol=$OPTARG ;;
    esac 
done

# Get all ids from query fasta file
get_all_ids() {
    sed -n 's/>\([^ ]\+\).*/\1/p' $focal_seqs
}

# All query ids that have significant hits in the BLAST results
get_non_orphan_ids() {
    awk -v s=$score -v c=$idcol \
        'NR > 1 && $c < s {print $c}' $blast_dir/*$blast_ext |
        uniq | sort -u
}

# Write list of orphans to STDOUT
cat $(get_all_ids) $(get_non_orphan_ids) | sort | uniq -u
