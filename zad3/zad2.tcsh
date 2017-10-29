#!/bin/tcsh
#Klara Muzalewska

./properIP.tcsh "$1"
set resultA=$?
./properIP.tcsh "$2"
set resultB=$?
if ( $resultA == 1 ) then
	echo Bad first IP.
	exit 1
else if ( $resultB == 1 ) then
	echo Bad second IP.
	exit 1
else
	set IPfirst=$1
	#echo $IPfirst
	set IPsecond=$2
	#echo $IPsecond
endif

set port_list=$3
set nrOfPorts=`echo $port_list | tr ',' ' ' | wc -w`
# echo $nrOfPorts

set IP="$IPfirst"
set A=`echo "$IP"| cut -d '.' -'f1'`
set B=`echo "$IP"| cut -d '.' -'f2'`
set C=`echo "$IP"| cut -d '.' -'f3'`
set D=`echo "$IP"| cut -d '.' -'f4'`

set INT=`expr  256 "*" 256 "*" 256 "*" $A`
set INT=`expr  256 "*" 256 "*" $B + $INT`
set INT=`expr  256 "*" $C + $INT`
set INT=`expr  $D + $INT`


set begin=$INT

set IP="$IPsecond"
set A=`echo "$IP"| cut -d '.' -'f1'`
set B=`echo "$IP"| cut -d '.' -'f2'`
set C=`echo "$IP"| cut -d '.' -'f3'`
set D=`echo "$IP"| cut -d '.' -'f4'`

set INT=`expr  256 "*" 256 "*" 256 "*" $A`
set INT=`expr   256 "*" 256 "*" $B + $INT`
set INT=`expr  256 "*" $C + $INT`
set INT=`expr  $D + $INT`
#echo ddsf
set end=$INT

if ( $begin > $end ) then
	set tmp=$end
	set end=$begin
	set begin=$tmp
endif

foreach i ( `seq $begin 1 $end` )
	#./int_to_ip.tcsh "$i"
	#echo $IP
	set INT="$i"
	set D=`expr  $INT % 256`
	set C=`expr '(' $INT - $D ')' / 256 % 256`
	set B=`expr '(' $INT - $C - $D ')' / 65536 % 256`
	set A=`expr '(' $INT - $B - $C - $D ')' / 16777216 % 256`
	set IP="$A.$B.$C.$D"
	ping -c1 -w3 $IP > /dev/null
	set my_ping=$?
	if ( $my_ping == 0 ) then
    	foreach p ( `seq $nrOfPorts` )
			set port=`echo "$port_list"|cut -d "," -"f$p"`
			set state=`echo get | nc -w1 $IP $port`
			if ( ${#state} == 0 ) then
				echo "$IP : $port is not responding"
			else if ( "" != `echo $state[1] | grep -Eio 'HTTP'` ) then
				echo "$IP : $port $state[1] $state[13]"		
			else
				echo "$IP : $port $state[1]"
			endif
		end
	else
    	echo "$IP dead"
	endif
end