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

a = raw_input("Wpisz wspołczynnik a do rownania, które chcesz rozwiązać: ")
if not isfloat(a):
		print 'Wrong argument to equation.'
		sys.exit(0)
a=float(a)
b = raw_input("Wpisz wspołczynnik b do rownania, które chcesz rozwiązać: ")
if not isfloat(b):
		print 'Wrong argument to equation.'
		sys.exit(0)
b=float(b)
c = raw_input("Wpisz wspołczynnik a do rownania, które chcesz rozwiązać: ")
if not isfloat(c):
		print 'Wrong argument to equation.'
		sys.exit(0)
c=float(c)


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