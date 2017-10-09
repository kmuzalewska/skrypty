#!/bin/tcsh
#Klara Muzalewska

# if ( "$1" !~ ^[0-9]+$  | "$2" !~ ^[0-9]+$ ) then
#     echo Bad parameters
#     exit 1
# echo $input | awk ' { if ( $0 ~ /[0-9]/ )
#                       printf " Numeric Input"
#                 else printf " String input " } '
@ va= `echo $2 | grep '^[-,0-9]*$'`
@ va2= `echo $1 | grep '^[-,0-9]*$'`
if ( ! $va | ! $va2) then
	echo Bad parameters
     	exit 1
	else if ( "$1" > "$2" ) then
		set i = "$1"
		@ k=$2 - 1
		while ( "$i" > "$k")
			set j = $1
			while ( "$j" > "$k" )
				@ result= $i * $j
			 	printf "| %3s " $result
			 	@ j-=1 ;
			 end
			 	echo "|"
				@ i-=1 ;
		end
	else
		foreach i ( `seq $1 $2` )
		 	foreach j ( `seq $1 $2` )
		 		@ result= $i * $j
		 		printf "| %3s " $result
		end
		echo "|"
		end
endif
endif