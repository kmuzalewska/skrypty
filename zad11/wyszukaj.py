#!/usr/bin/python
# -*- coding: utf-8 -*-


#Klara Muzalewska

import re
import string
import os

def findPhrase(phrase, folder):
    for root, directories, filenames in os.walk(folder):
        # print folder
        for filename in filenames:
            frequency = {}
            f=os.path.join(root,filename)  
            document_text = open(f, 'r')
            text_string = document_text.read()
            pattern = re.compile(phrase)
            match_pattern = re.findall(pattern, text_string)
            for word in match_pattern:
                count = frequency.get(word,0)
                frequency[word] = count + 1
            frequency_list = frequency.keys()        
            for words in frequency_list:
                print f, words, frequency[words]





findPhrase('Klara', '/home/klara/Studia/IIst/Isemestr/skrypty/')
