#!/bin/bash

for j in protein-sequences/*.faa
do
    echo =====================================================
    echo $j
    echo -----------------------------------------------------
    head -3 -f 12 -l 12 $j
    echo -----------------------------------------------------
    smof stat -C $j
    echo -----------------------------------------------------
    smof info $j
    echo =====================================================
    echo
done > protein-sequences-statistics.txt