#!/usr/bin/python
# -*- coding: utf-8 -*-


#Klara Muzalewska

import sys
import os
import re
import mimetypes
import os
import rex
arguments = sys.argv[1:]
nrOfArguments = len(arguments)
dflag = 0
iflag = 0
wflag = 0
cflag = 0
lflag = 0
files = []
openType = "rb"
totalNrOfWords =0
totalNrOfLines =0
totalNrOfBytes = 0
totalNrOfIntegers = 0
totalNrOfDigits = 0
for i in arguments:
    if i=='-d':
        dflag = 1
    elif (i=='-i'):
        iflag = 1
    elif (i=='-w'):
        wflag =1
    elif (i=='-c'):
        cflag = 1
    elif (i=='-l'):
        lflag = 1
    elif re.match('/^-/', i): 
        print "Wriong option.\n Avaliable:\n -N\n -n\n -f\n -v\n";
        sys.exit()
    elif not re.match('/^-/', i):
        files.append(i)

nrOfFlag=dflag + iflag + wflag + cflag + lflag

for i in files:
  if not os.path.isfile(i):
    print("File path {} does not exist. ".format(i))
    continue
  # if nrOfFlag==0:
  #   cnt=""
  # elif nflag==1:
  #   cnt=1
  with open(i, openType) as fp:
    text = fp.read()
    #print text
    words = len(text.split())
    lines = len(text.splitlines())
    byte = os.path.getsize(i)
    integer = sum(c.isdigit() for c in text)
    digit = len(re.findall( rex.giveDigitRex() , text))
    totalNrOfWords += words
    totalNrOfLines += lines
    totalNrOfBytes += byte
    totalNrOfIntegers += integer
    totalNrOfDigits += digit
    if nrOfFlag ==0:
        print lines, ' ', words, ' ', byte
    else:
        for i in arguments:
            if i=='-d':
                print digit,
            elif (i=='-i'):
                print integer,
            elif (i=='-w'):
                print words,
            elif (i=='-c'):
                print byte,
            elif (i=='-l'):
                print lines,
        print
        
    

if len(files)>1:
    if nrOfFlag ==0:
        print totalNrOfLines, ' ', totalNrOfWords, ' ', totalNrOfBytes
    else:
        for i in arguments:
            if i=='-d':
                print totalNrOfDigits,
            elif (i=='-i'):
                print totalNrOfIntegers,
            elif (i=='-w'):
                print totalNrOfWords,
            elif (i=='-c'):
                print totalNrOfBytes,
            elif (i=='-l'):
                print totalNrOfLines,
        print
