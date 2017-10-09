#!/bin/bash
#Klara Muzalewska

for i in $(seq 1 9); do
	for j in $(seq 1 9); do
		printf "| %3s " $(($i * $j))
	done
	echo "|"
done
