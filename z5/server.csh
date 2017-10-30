#!/bin/tcsh
#Dawid Tracz gr.2

set i = 1
set port = 5000
set IP = "localhost"
set ncset = /.ncset.csh
set ncount = /.ncount.csh

set ifset = 0
set ifserver = 0
set ifclient = 0

source ${HOME}/.licznik.csh
source ${HOME}$ncset
source ${HOME}$ncount

while ($#)
	switch($1)
		case -p:
		case --port:
			set port = $2
			if ( $port != `echo $port | grep -Eio '^[0-9]+$'` ) then
				echo "port should be an integer number ($port)"; exit 1
			endif
			shift; shift; breaksw
		case -i:
		case --IP:
			set IP = $2
			if ( $IP != `echo $IP | grep -Eio '(^([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$)|(^localhost$)'` ) then
				echo "IP: $IP - bad adress"; exit 1
			endif
			shift; shift; breaksw
		case -r:
		case --reset:
			set i = 1
			echo "set i = $i" >! ${HOME}$ncount
			shift; breaksw
		case -s:
		case --server:
			set ifserver = 1
			shift; breaksw
		case -c:
		case --client:
			set ifclient = 1
			shift; breaksw
		case --save:
			echo "set port = $port\nset IP = $IP" >! ${HOME}$ncset
			shift; breaksw
		case --sset:
			set ncset = $2
			source $ncset
			set ncset = `echo $ncset | awk -F"${HOME}" '{print $2}'`
			if ( $port != `echo $port | grep -Eio '^[0-9]+$'` ) then
				echo "port should be an integer number ($port)"; exit 1
			endif
			if ( $IP != `echo $IP | grep -Eio '(^([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$)|(^localhost$)'` ) then
				echo "IP: $IP - bad adress"; exit 1
			endif
			set ifset = 1
			shift; shift; breaksw
		case --cset:
			set ncount = $2
			source $ncount
			set ncount = `echo $ncount | awk -F"${HOME}" '{print $2}'`
			if ( $i != `echo $i | grep -Eio '^[0-9]+$'` ) then
				echo "incorrect counter in given file ($1)"; exit 1
			endif
			set ifset = 1
			shift; shift; breaksw
		default:
			echo "unknown option $1"
			shift; breaksw
	endsw
end

if ( $ifset ) then
	echo "set ncset = $ncset\nset ncount = $ncount"  >! ${HOME}/.licznik.csh
endif

#echo "_____________"
#echo "ncset=$ncset"
#echo "ncount=$ncount"
#echo "i=$i"
#echo "port=$port"
#echo "IP=$IP"

if ( $ifclient && ! $ifserver ) then
	nc $IP $port
	exit 1
endif

while ( 1 )
	if ( "`netstat -ntpl |& grep -Eio $port`" != "" ) then
		echo "someone's here alredy listening on port $port"; exit 1
	else
		`echo "Number of calls: $i" | nc -l $IP -p $port` |& grep -Eio '^$'
		@ i = $i + 1
		echo "set i = $i" >! ${HOME}$ncount
		wait
	endif
end