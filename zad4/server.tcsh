#!/bin/tcsh
#Klara Muzalewska

set fileName = `basename $0 .tcsh`
set licznikPlace=${HOME}
set portPlace=${HOME}

set IP=127.0.0.1
set port=8080

set client=0
set serwer=1
set setFileName=false
set mind=""
set octet="([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])"

set licznikPlace=`cat $licznikPlace/.licznikPlace.rc`
if ! ( -d $licznikPlace ) then
	echo "Wrong path"
	exit 1
endif


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
		set flagPort=1
		shift;
		breaksw
	case -i:
		shift;
		if ( $1 != `echo $1 | grep -Eio '(^([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$)|(^localhost$)'` ) then
			echo "Wrong IP address $1"
			exit 1;
		endif ; 
		set IP=$1
		set flagIP=1
		shift;
		breaksw
	case -c:
		set client=1
		set serwer=0
		set mind="$mind+client"
		shift;
		breaksw
	case -s:
		set serwer=1
		set mind="$mind+serwer"
		shift;
		breaksw
	case -lp:
		shift
		if ! ( -d $1 ) then
			echo "Wrong path"
			exit 1
		endif ;
		cp $licznikPlace/.licznik.rc $1/.licznik.rc
		set licznikPlace=$1
		shift ;
		breaksw
	default:
		echo "Wrong option"
		exit 1
		breaksw
	endsw
end

if ( "$mind" == "+client+serwer" | "$mind" == "+serwer+client" ) then
	echo "Pick one: client or server"
	exit 1
endif

if ( $fileName == "serwer" ) then
    echo "Serwer is set on the port:" $port
	nc -lk $IP $port
else if ( $fileName == "client" | $client == 1 ) then
	set serwer=0
    set setFileName=true
    set adres="$IP $port"
    set adresExisting=false

    foreach line ("`cat $licznikPlace/.licznik.rc`")
        if ( "$line" =~ "$adres*" ) then
            set adresExisting = true
        endif
    end

    if ( $adresExisting == false ) then
        echo "$adres 0" >> $licznikPlace/.licznik.rc
    endif

    nc -vw1 $IP $port

    if( "$?" == "0" ) then
	    set adres="$IP $port"
	    echo 
	    echo -n "Number of calls on the port" $port": "
	    foreach line ( "`cat $licznikPlace/.licznik.rc`" )
	      	if ( "$line" =~ "$adres*" ) then
	           	set tmpLine = "$line"        
	           	set counter = `echo "$line" | cut -d ' ' -f 3`
	           	@ counter = $counter + 1
	           	echo $counter  
	           	set tmpLineSecond = "$adres $counter"
	           	sed -i "s/$tmpLine/$tmpLineSecond/g" "$licznikPlace/.licznik.rc"
	       	endif
	    end
    else
	    echo "This port is in use. Pick another"
        exit 1
    endif
endif

if ( $serwer == 1 ) then
    echo "Serwer is set on the port:" $port
	nc -lk $IP $port
endif

echo