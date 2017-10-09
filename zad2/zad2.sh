#!/bin/bash
#Klara Muzalewska


if ! [[ "$1" =~ ^[-,0-9]+$ ]] || ! [[ "$2" =~ ^[-,0-9]+$ ]]; then
    	echo Bad parameters
        exit 1
    elif [[ "$1" -gt "$2" ]]; then
    	i="$1"
    	k=$(($2-1))
		while [ "$i" -gt "$k" ]; do 
			j=$1
			while [ "$j" -gt "$k" ]; do 
				printf "| %5s " $(($i * $j)); j=$((j-1)); done
			echo "|"
			i=$((i-1))
		done
	else
		for i in $(seq $1 $2); do
			for j in $(seq $1 $2); do
				printf "| %5s " $(($i * $j))
			done
			echo "|"
		done
fi


