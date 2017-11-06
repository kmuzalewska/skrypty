cp_one:
	cp $(f) ~/.$(f)

ready:
	chmod u+x server*
	chmod u+x terminator.sh
	make f=licznik.rc cp_one
	make f=licznik.csh cp_one
	make f=ncset.rc cp_one
	make f=ncset.csh cp_one
	make f=ncount.dat cp_one
	make f=ncount.csh cp_one
	clear
