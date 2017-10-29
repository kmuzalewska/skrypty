#!/bin/tcsh
#Klara Muzalewska


foreach i ( `seq 1 9` )
	foreach j  ( `seq 1 9` ) 
		@ result= $i * $j #`$i * $j`
		printf "| %3s " $result
	end
	echo "|"
end
