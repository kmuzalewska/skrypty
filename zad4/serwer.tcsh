#!/bin/tcsh
#Klara Muzalewska


set licznikPlace=${HOME}
set portPlace=${HOME}

echo $portPlace > portPlace.rc
echo $licznikPlace > licznikPlace.rc

cp licznik.rc $licznikPlace/.licznik.rc
cp port.rc $portPlace/.port.rc
cp licznikPlace.rc $licznikPlace/.licznikPlace.rc
cp portPlace.rc $portPlace/.portPlace.rc

set licznikPlace=`cat $licznikPlace/.licznikPlace.rc`
if ! ( -d $licznikPlace ) then
	echo "Wrong path"
	exit 1
endif ; 

set portPlace=`cat $portPlace/.portPlace.rc`
if ! ( -d $portPlace ) then
	echo "Wrong path"
	exit 1
endif ; 


set IP=localhost
set port=8080

set octet="([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])"
set i = 1
set client=0
set serwer=0
set port=`cat $portPlace/.port.rc`

while ($#)
	switch($1)
	case -p:
	case --port:
		shift;
		if (  $1 != `echo $1 | grep -Eio '^[0-9]+$'` ) then
			echo $1
			echo "Wrong number of port"
			exit 1
		endif ;
		set port=$1
		shift;
		breaksw
	case -i:
		shift;
		if ( $1 != `echo $1 | grep -Eio '(^([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$)|(^localhost$)'` ) then
			echo "Wrong IP address $1"
			exit 1;
		endif ; 
		set IP=$1
		shift;
		breaksw
	case -c:
	case --client.sh
		set client=1
		shift;
		breaksw
	case -s:
	case --serwer.sh
		set counter=$i
		echo $counter > $licznikPlace/.licznik.rc
		set serwer=1
		shift;
		breaksw
	case -pp:
	case --portPlace:
		shift;
		if ! ( -d $1 ) then
			echo "Wrong path"
			exit 1
		endif ;
		set portPlace=$1
		shift ;
		breaksw
	case -lp:
	case --licznikPlace:
		shift
		if ! ( -d $1 ) then
			echo "Wrong path"
			exit 1
		endif ;
		set licznikPlace=$1
		shift ;
		breaksw
	default:
		echo "Wrong option"
		exit 1
		breaksw
	endsw
end

if ( $client == 1 ) then
	nc $IP $port
else
	while ( 1 )
		if ( "`netstat -ntpl |& grep -Eio $port`" != "" ) then
			echo "This port is in use. Pick another"
			exit 1
		else
			`echo "Number of calls: $i" | nc -l $IP -p $port` |& grep -Eio '^$'
			@ i = $i + 1
			echo $i > $licznikPlace/.licznik.rc
			wait 
		endif
	end
endif
		