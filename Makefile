all:
	for j in protein_database/*db; do ./prepare-blast-pbs-scripts.sh `basename $j` blast.pbs; done

.PHONY: archive
archive:
	mkdir archive-`date +%F-%R`
	mv *error *output GM* *db*pbs archive-`date +%F-%R` 2> /dev/null

.PHONY: clean
clean:
	rm -f *.db*pbs
	rm -f *~
	rm -f *error
	rm -f *output

.PHONY: run
run:
	qsub *.db*pbs
