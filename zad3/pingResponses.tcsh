#!/bin/tcsh
#Klara Muzalewska

ping -c1 -w3 $1 > /dev/null
set p=$?

if ( $p == 0 ) then
    	echo "$1 Ping responded."
	else
    	echo "$1 Ping did not respond"
endif
exit 0