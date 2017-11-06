#!/bin/bash
#Dawid Tracz gr.2

B="([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])"

function port_check {
	if ! [ `echo $1 | grep -Eio "^[0-9]+$"` ]; then
		echo "incorrect port determination ($1)"; exit 1; fi }

function IP_check {
	if ! [ `echo $1 | grep -Eio "(^$B\.$B\.$B\.$B$)|(^localhost$)"` ]; then
		echo "incorrect IP determination ($1)"; exit 1; fi }

function i_check {
	if ! [ `echo $1 | grep -Eio "^[0-9]+$"` ]; then
		echo "incorrect counter in given file ($1)"; exit 1; fi }

function file_check {
	path=$1
	if [ `echo $path | grep -Ei "^${HOME}"` ]; then
		path=`echo $path | awk -F"${HOME}" '{print $2}'`; fi
	`source ${HOME}$path`
	i_check $i
	port_check $port
	IP_check $IP; }

i=1
port=5000
IP=localhost
ncset=/.ncset.rc
ncount=/.ncount.dat

ifset=0
ifserver=0
ifclient=0

source ${HOME}/.licznik.rc
source ${HOME}$ncset
source ${HOME}$ncount

while [[ $1 ]]; do
	case "$1" in
		-p|--port )
			port_check $2
			port=$2
			shift 2 ;;
		-i|--IP )
			IP_check $2
			IP=$2
			shift 2 ;;
		-r|--reset )
			i=1
			`echo "i=$i" > ${HOME}$ncount`
			shift ;;
		--save )
			`echo -e "port=$port\nIP=$IP" > ${HOME}$ncset`
			shift ;;
		--sset )
			file_check $2
			ncset=$path
			ifset=1
			shift 2 ;;
		--cset )
			file_check $2
			ncount=$path
			ifset=1
			shift 2 ;;
		-s|--server )
			ifserver=1
			shift ;;
		-c|--client )
			ifclient=1
			shift ;;	
		*)
			echo "incorrect option $1"
			shift ;;
	esac
done

if [[ $ifset -eq 1 ]]; then
	`echo -e "ncset=$ncset\nncount=$ncount" > ${HOME}/.licznik.rc`; fi

trap 'echo "i=$i" > ~$ncount' SIGTERM

#echo "ncset=$ncset"
#echo "ncount=$ncount"
#echo "i=$i"
#echo "port=$port"
#echo "IP=$IP"

if [[ `expr $ifclient - $ifserver` -gt 0 ]]; then
	netcat $IP $port
else
	while [ 1 ]; do
		if [ `echo $(netstat -ntpl 2>/dev/null)  | grep -Eio "$B\.$B\.$B\.$B:$port"` ]; then
			echo "someone's here alredy listening on port $port"; exit 1
		else
			`echo "Number of calls: $i" | nc -l $IP -p $port` 2>/dev/null
			i=$(($i+1))
			wait ; fi
	done
fi