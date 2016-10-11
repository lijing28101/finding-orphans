all:
	./make-scripts.sh

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

.PHONY: test
test:
	qsub Cic*pbs
	sleep 1
	qstat -u jingli

# add a remove archive command
