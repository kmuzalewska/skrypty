#!/usr/bin/python

import sys

rangeOfMultiply = str(sys.argv[1])
if rangeOfMultiply.isdigit():
	r = int(rangeOfMultiply)
else:
	print "Bad argument"
	sys.exit(0)

for i in xrange(1, r+1):
	for  j in xrange(1, r+1):
		print i*j,
	print
	

