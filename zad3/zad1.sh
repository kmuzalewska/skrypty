#!/bin/bash
#Klara Muzalewska

properIP () {
	IP=$1
	result=0
	if [[ $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
		for i in 1 2 3 4; do
    		if [ $(echo "$IP" | cut -d. -f$i) -gt 255 ]; then
      			result=1
      			break
			fi
		done
	else
		result=1
	fi 
	return $result; }

pingResponses () {
	if ping -c1 -w3 $1 >/dev/null 2>&1
	then
    	echo "$1 Ping responded." >&2
	else
    	echo "$1 Ping did not respond" >&2
	fi ; }



ip_to_int()
{
  local IP="$1"
  local A=`echo $IP | cut -d. -f1`
  local B=`echo $IP | cut -d. -f2`
  local C=`echo $IP | cut -d. -f3`
  local D=`echo $IP | cut -d. -f4`
  local INT

  INT=`expr 256 "*" 256 "*" 256 "*" $A`
  INT=`expr 256 "*" 256 "*" $B + $INT`
  INT=`expr 256 "*" $C + $INT`
  INT=`expr $D + $INT`

  echo $INT ; }



int_to_ip()
{
  local INT="$1"

  local D=`expr $INT % 256`
  local C=`expr '(' $INT - $D ')' / 256 % 256`
  local B=`expr '(' $INT - $C - $D ')' / 65536 % 256`
  local A=`expr '(' $INT - $B - $C - $D ')' / 16777216 % 256`

  echo "$A.$B.$C.$D" ; }



if ! properIP $1; then
	echo Bad first IP.
	exit 1
elif ! properIP $2; then
	echo Bad second IP.
	exit 1
else
	IPfirst="$1"
	echo $IPfirst
	IPsecond="$2"
	echo $IPsecond
fi

#aby użyć nazw domenowych należy najpierw zamienić hostname na numer IP za pomocą dig +short argument a następnie
#kontynuować skrypt tak jak jest to ponizej

begin=`ip_to_int $IPfirst`

end=`ip_to_int $IPsecond`

if [[ $begin -gt $end ]]; then
	tmp=$end
	end=$begin
	begin=$tmp
fi

for INT in `seq $begin 1 $end`
do
  IP=`int_to_ip $INT`
  pingResponses $IP
done

