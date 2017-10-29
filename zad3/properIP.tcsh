#!/bin/tcsh
#Klara Muzalewska

set IP=$1
set result=0
set va=`echo $IP | grep -Eio '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'`
if ( $va != 0 && $va != "") then
	foreach i ( `seq 1 4` )
	set tmp=`echo "$IP"|cut -d. -f$i`
   		if ( $tmp > "255" ) then
  			set result=1
   			break
		endif
	end
else
	set result=1
endif 
#echo $result
exit $result