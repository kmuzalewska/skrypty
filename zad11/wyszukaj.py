#!/usr/bin/python
# -*- coding: utf-8 -*-


#Klara Muzalewska

import re
import string
import os
import sys
import findPhrase

# def findPhrase(phrase, folder):
#     count=0
#     for root, directories, filenames in os.walk(folder):
#         for filename in filenames:
#             f=os.path.join(root,filename)  
#             document_text = open(f, 'r')
#             text_string = document_text.read()
#             pattern = re.compile(phrase)
#             match_pattern = re.findall(pattern, text_string)
#             for word in match_pattern:
#                 count+=1          
#     print folder, phrase, count

args= sys.argv[1:]
if len(args)<3:
    print 'Too few arguments'
    sys.exit()

directories=[]
while len(args):
    while len(args) and args[0] == '-d':
        if os.path.isdir(args[1]):
            directories.append(args[1])
        else:
            print "Wrong directory: ", args[1]
        args=args[2:]
    while len(args) and args[0] != '-d':
        for i in directories:
            findPhrase.findPhrase(args[0], i)
        args=args[1:]
    directories=[]   