#!/bin/bash
#Klara Muzalewska



licznikPlace=${HOME}
portPlace=${HOME}

echo $portPlace > portPlace.rc
echo $licznikPlace > licznikPlace.rc

cp licznik.rc $licznikPlace/.licznik.rc
cp port.rc $portPlace/.port.rc
cp licznikPlace.rc $licznikPlace/.licznikPlace.rc
cp portPlace.rc $portPlace/.portPlace.rc



properPort () {
	if ! [ `echo $1 | grep -Eio "^[0-9]+$"` ]; then
		echo "Wrong number of port"
		exit 1
	fi ;
}

properIP () {
	IP=$1
	result=0
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



licznikPlace=$(<$licznikPlace/.licznikPlace.rc)
properPlace $licznikPlace
portPlace=$(<$portPlace/.portPlace.rc)
properPlace $portPlace

i=1
IP=localhost
port=8080

octet="([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])"

client=0
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
	-c )
		client=1
		#echo $client
		shift
		;;
	-s )
		counter=$i
		echo $counter > $licznikPlace/.licznik.rc
		serwer=1
		shift
		;;
	-pp| --portPlace )
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
		exit 1
		;;
	esac
done

if [[ $client -gt $serwer ]]; then
	nc $IP $port
else
	while [ 1 ]; do
		if [ `echo $(netstat -ntpl 2>/dev/null)  | grep -Eio "$octet\.$octet\.$octet\.$octet:$port"` ]; then
			echo "This port is in use. Pick another"
			exit 1
		else
			`echo "Number of calls: $i" | nc -l $IP -p $port` 2>/dev/null
			i=$(($i+1))
			echo $i > $licznikPlace/.licznik.rc
			wait 
		fi
	done
fi
		


