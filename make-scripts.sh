#!/bin/bash

 for j in protein_database/*db; do ./prepare-blast-pbs-scripts.sh `basename $j` blast.pbs; done
