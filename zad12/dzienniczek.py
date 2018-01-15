#!/usr/bin/python
# -*- coding: utf-8 -*-


#Klara Muzalewska

import re
import string
import os
import sys
import numpy

# numpy.mean(a)
grades={'2+':2.25, '+2':2.25, '3+':3.25, '+3':3.25, '4+':4.25, '+4':4.25, '5+':5.25, '+5':5.25,
        '2-':1.75, '-2':1.75, '3-':2.75, '-3':2.75, '4-':3.75, '-4':3.75, '5-':4.75, '-5':4.75 }

files= sys.argv[1:]
meanR=[]
for i in files:
    registerToPrint = {}
    registerToCount = {}
    if not os.path.isfile(i):
        print("File path {} does not exist. ".format(i))
        continue
    with open(i, "rb") as fp:
        text = fp.read()
        for line in text.splitlines():
            data = line.split()
            name = data[0].title()
            surname = data[1].title()
            nsur = surname + ' ' + name
            try:
                grade = float(data[2])
            except ValueError:
                grade = data[2]
            if 1.75 <= grade and grade <=5.25:
                registerToPrint.setdefault(nsur,[]).append(grade)
                registerToCount.setdefault(nsur,[]).append(grade)
            elif re.match('^([+-][2-5])|([2-5][+-])$', grade):
                registerToPrint.setdefault(nsur,[]).append(grade)
                registerToCount.setdefault(nsur,[]).append(grades[grade])
            else:
                print("I got {}. Number has bad format.\n".format(grade)) 
        print "\n", i, "\n"
        for name in registerToPrint.keys():
            meanV = round(numpy.mean(registerToCount[name]), 2)
            print name, ': ', registerToPrint[name], ': ', meanV
            meanR.append(meanV)
        print "Srednia ocen w calym pliku: {}\n".format(round(numpy.mean(meanR), 2))


