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
	echo $IPfirst
	set IPsecond=$2
	echo $IPsecond
endif


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
	./pingResponses.tcsh $IP
end