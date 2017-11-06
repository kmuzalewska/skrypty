#!/bin/bash
#Klara Muzalewska, grupa 1

fileName=$(basename $0 .sh)

IP=127.0.0.1
port=8080

client=0
serwer=1
setFileName=false
mind=""
octet="([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])"

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
	if ! [[ -d $path ]]; then
		echo "Wrong path"
		exit 1
	fi ; 
}

licznikPlace=$(<${HOME}/.licznikPlace.rc)
properPlace $licznikPlace

createSerwer() {
	echo "Serwer is set on the port:" $port
	nc -lk $IP $port ;
}

listenClient() {
    nc -vw1 $IP $port 
    case $? in
    0)
        adres="$IP $port"
        echo -n "Number of calls on the port $port: "
        while IFS= read -r line; do
        if [[ $line == $adres* ]]; then
            tmpLine=$line        
            counter=$(echo "$line" | cut -d ' ' -f 3)
            (( counter = $counter + 1))
            echo $counter  
            tmpLineSecond="$adres $counter"
            sed -i "s/$tmpLine/$tmpLineSecond/g" "$licznikPlace/.licznik.rc"
        fi
        done < "$licznikPlace/.licznik.rc"
    ;;
    1)
        echo "This port is in use. Pick another"
        exit 1
    ;;
    esac ;
}

setCounter() {
	adres="$IP $port"
    adresExisting=false

    while IFS= read -r line; do
        if [[ $line == $adres* ]]; then
            adresExisting=true
        fi
    done < "$licznikPlace/.licznik.rc"

    if [ $adresExisting == false ]; then
        echo "$adres 0" >> $licznikPlace/.licznik.rc
    fi ;
}

while [[ $1 ]]; do
	case "$1" in
	-p| --port )
		shift
		properPort $1
		port=$1
		flagPort=1
		shift
		;;
	-i )
		shift
		properIP $1
		IP=$1
		flagIP=1
		shift
		;;
	-c )
		client=1
		serwer=0
		mind="$mind+client"
		shift
		;;
	-s )
		serwer=1
		mind="$mind+serwer"
		shift
		;;
	-lp| --licznikPlace )
		shift
		properPlace $1
		cp $licznikPlace/.licznik.rc $1/.licznik.rc
		licznikPlace=$1
		shift 
		;;
	*)
		echo "Wrong option"
		exit 1
		;;
	esac
done

if [[ $mind == "+client+serwer" ]] || [[ $mind == "+serwer+client" ]];then
	echo "Pick one: client or server"
	exit 1
fi

if [ $fileName == "serwer" ]; then
    setFileName=true
    createSerwer
elif [ $fileName == "client" ]; then
    setFileName=true
    echo cli
    setCounter
    listenClient
fi

if [ $setFileName == false ];then
	if [[ $serwer -eq 1 ]]; then
        createSerwer
    elif [[ $client -eq 1 ]]; then   
        setCounter
        listenClient
    fi
fi