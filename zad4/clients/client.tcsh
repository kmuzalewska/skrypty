#!/bin/tcsh
#Klara Muzalewska

#First run server.sh then You can run client.sh 


set licznikPlace=${HOME}
set portPlace=${HOME}

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

set counter=`cat $licznikPlace/.licznik.rc`
set port=`cat $portPlace/.port.rc`

while ($#)
	switch($1)
		case -p:
		case --port:
			shift;
			if (  $1 != `echo $1 | grep -Eio '^[0-9]+$'` ) then
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
			shift;
			breaksw
	endsw
end

nc $IP $port