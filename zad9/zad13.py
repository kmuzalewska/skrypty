#!/usr/bin/python
# -*- coding: utf-8 -*-

import math
import sys
import getopt

def isfloat(str):
    try: 
        float(str)
    except ValueError: 
        return False
    return True
##ax^2+bx+c=0
# a=1
# b=0
# c=1
arguments= sys.argv[1:]

if len(arguments)<3:
	print 'Wrong number of arguments.'
	sys.exit(0)

for i in arguments[:3]:
	if not isfloat(i[2:]):
		print 'Wrong arguments to equation.'
		sys.exit(0)
	if i[:2]=='a=':
		a=float(i[2:])
	elif i[:2]=='b=':
		b=float(i[2:])
	elif i[:2]=='c=':
		c=float(i[2:])

print "\nRownanie:\n",a,"*x^2+",b,"*x+",c
delta = pow(b,2)-4*a*c
if delta>0:
	x1=-(b+math.sqrt(delta))/(2*a)
	x2=-(b-math.sqrt(delta))/(2*a)
	print "\nRozwiązania:\n x1 =", x1, " \n x2 =", x2, "\n"
elif delta==0:
	x1=-b/(2*a)
	x2=x1
	print "\nRozwiązania:\n x1 =", x1, " \n x2 =", x2, "\n"
elif delta<0:
	xp1=(-b/(2*a))
	xs1=math.sqrt(-delta)/(2*a)
	print "\nRozwiązania:\n x1 =", xp1, "+i *",xs1, " \n x2 = ", xp1, "-i *",xs1