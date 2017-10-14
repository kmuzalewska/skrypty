#!/bin/bash
#Klara Muzalewska

n=0
oper=0
digitrgx="^\-?([0-9]*\.[0-9]+)"
intrgx="^\-?[0-9][0-9]*$"
oprgx="^([samdp]|mod)$"

for i in $@
do
	if [[ $i == "--help" ]] || [[ $i == "-h" ]]; then
      echo
      echo 'Program is created by Klara Muzalewska to display the table with result of aritmetical operation'
      echo
      echo 'Possible parameter:'
      echo
      echo '  ./[FILENAME] -h   --help  Displays the possible options of the program'
      echo
      echo 'Possible operators:'
      echo '        s substitution'
      echo '        a adding'
      echo '        m multiplication'
      echo '        d division'
      echo '        p power'
      echo '        mod modulo'
    exit 0
	elif [[ $i =~ $intrgx ]]; then
		case "$n" in
  			"0") n=1
 				arg1=$i;;
  			"1") n=2
  				arg2=$i;;
  			"2") continue ;;
		esac
	elif [[ $i =~ $oprgx ]] && [[ $oper == 0 ]]; then
		oper=1
  	operator=$i
  elif [[ $i =~ $digitrgx ]]; then
  	echo Bad numbers
		exit 1
	else
  	echo 'Bad operators. Possible operators:'
  	echo '				s substitution'
		echo '				a adding'
 		echo '				m multiplication'
		echo '				d division'
		echo '				p power'
		echo '				mod modulo'
		exit 2
	fi
done

if [[ $n == 2 ]] && [[ $oper == 1 ]]; then
  if [[ "$arg1" -gt "$arg2" ]]; then
      i="$arg1"
      k=$(($arg2-1))
    while [ "$i" -gt "$k" ]; do 
      j=$arg1
      while [ "$j" -gt "$k" ]; do 
        case "$operator" in
          "s") printf "| %5s " $(($i - $j)) ;;
          "a") printf "| %5s " $(($i + $j));;
          "m") printf "| %5s " $(($i * $j));;
          "d") printf "| %5s " $(($i / $j)) ;;
          "p") printf "| %5s " $(($i ** $j)) ;;
          "mod") printf "| %5s " $(($i % $j));;
        esac
        j=$((j-1))
        done
      echo "|"
      i=$((i-1))
    done
  else
    for i in $(seq $arg1 $arg2); do
      for j in $(seq $arg1 $arg2); do
        case "$operator" in
          "s") printf "| %5s " $(($i - $j)) ;;
          "a") printf "| %5s " $(($i + $j));;
          "m") printf "| %5s " $(($i * $j));;
          "d") printf "| %5s " $(($i / $j)) ;;
          "p") printf "| %5s " $(($i ** $j)) ;;
          "mod") printf "| %5s " $(($i % $j));;
        esac
      done
      echo "|"
    done
  fi
fi