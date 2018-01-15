#!/usr/bin/python
# -*- coding: utf-8 -*-


#Klara Muzalewska

import os
import re
import string

def findPhrase(phrase, folder):
    count=0
    for root, directories, filenames in os.walk(folder):
        for filename in filenames:
            f=os.path.join(root,filename)  
            document_text = open(f, 'r')
            text_string = document_text.read()
            pattern = re.compile(phrase)
            match_pattern = re.findall(pattern, text_string)
            for word in match_pattern:
                count+=1          
    print folder, phrase, count