#!/bin/bash
#Klara Muzalewska

properPort () {
	if ! [ `echo $1 | grep -Eio "^[0-9]+$"` ]; then
		echo "Wrong number of port"
		exit 1
	fi ;
}

properIP () {
	IP=$1
	if ! [[ $IP =~ (^$octet\.$octet\.$octet\.$octet$)|(^localhost$) ]]; then
		echo "Wrong IP address $IP"
		exit 1;
	fi ; 
}

properCounter () {
	if ! [[ $1 =~ ^[0-9]+$ ]]; then
		echo "Wrong counter $counter "
		exit 1; 
	fi ;
}

properPlace () {
	path=$1
	#echo $path
	if ! [[ -d $path ]]; then
		echo "Wrong path"
		exit 1
	fi ; 
}

licznikPlace=${HOME}
portPlace=${HOME}

licznikPlace=$(<$licznikPlace/.licznikPlace.rc)
properPlace $licznikPlace
portPlace=$(<$portPlace/.portPlace.rc)
properPlace $portPlace


IP=localhost
port=8080

counter=$(<$licznikPlace/.licznik.rc)
port=$(<$portPlace/.port.rc)

while [[ $1 ]]; do
	case "$1" in
	-p| --port )
		shift
		properPort $1
		port=$1
		#echo $port
		shift
		;;
	-i )
		shift
		properIP $1
		IP=$1
		#echo $IP
		shift
		;;
	pp| --portPlace )
		shift
		properPlace $1
		portPlace=$1
		shift 
		;;

	-lp| --licznikPlace )
		shift
		properPlace $1
		licznikPlace=$1
		shift 
		;;
	*)
		echo "Wrong option"
		shift 
		;;
	esac
done

nc $IP $port


