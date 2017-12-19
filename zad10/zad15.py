#!/usr/bin/python
# -*- coding: utf-8 -*-


#Klara Muzalewska

import sys
import os
import re
import mimetypes

arguments = sys.argv[1:]
nrOfArguments = len(arguments)
Nflag = 0
nflag = 0
vflag = 0
lines = 1
fflag = 0
files =[]

openType = "rb"
cnt = 1
for i in arguments:
    if i=='-N':  #numerowanie linii dla wszystkich plikow razem
        Nflag = 1
    elif (i=='-n'): #numerowanie linii dla kazdego pliku osobno
        nflag = 1
    elif (i=='-f'): #czytanie binarek
        fflag =1
    elif (i=='-v'):
        vflag = 1   #wlaczenie pokazywania komentarzy
    elif re.match('/^-/', i): 
        print "Wriong option.\n Avaliable:\n -N\n -n\n -f\n -v\n";
        sys.exit()
    elif not re.match('/^-/', i):
        files.append(i)

nrOfFlag=Nflag+nflag

for i in files:
  if not os.path.isfile(i):
    print("File path {} does not exist. ".format(i))
    continue
  if nrOfFlag==0:
    cnt=""
  elif nflag==1:
    cnt=1
  with open(i, openType) as fp:
    typeD,_ = mimetypes.guess_type(i)
    if not 'text' in typeD and not fflag:
      print "Wrong file"
      continue
    line = fp.readline()
    while line:
      #line = fp.readline()
      content, sep, removed = line.strip().partition('#')
      if vflag == 1:
        content = line.strip()
      print("{} {}".format(cnt, content))
      line = fp.readline()
      if type(cnt) is int:
        cnt+=1

