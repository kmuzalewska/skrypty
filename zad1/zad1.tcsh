	#!/bin/tcsh
#Klara Muzalewska

set USERE=$(id -u -n)


 for i in $*
 do
 	if [ $i == "--help" ] || [ $i == "-h" ]; then
 		echo
		echo 'Program is created by Klara Muzalewska to display the login, name and surname of the current user.'
		echo
		echo 'Possible parameter:'
		echo
		echo '	./[FILENAME] 			Displays the login, name and surname of the current user'
		echo '	./[FILENAME] -h 	--help	Displays the possible options of the program'
		echo '	./[FILENAME] -q 	--quit	Ends the program'
 		exit 0
 	elif [ $i == "--quit" ] || [ $i == "-q" ]; then
		set q=1 && continue
	elif [ $i == "-"* ] || [ $i == "--"* ]; then
		set v=1 && continue
	fi
done

if [ $q == 1 ]; then
	exit 0
elif [ $v == 1 ]; then
	echo $i, wrong parameter, see: 
	echo
	echo 'Program is created by Klara Muzalewska to display the login, name and surname of the current user.'
	echo
	echo 'Possible parameter:'
	echo
	echo '	./[FILENAME] 			Displays the login, name and surname of the current user'
	echo '	./[FILENAME] -h 	--help	Displays the possible options of the program'
	echo '	./[FILENAME] -q 	--quit	Ends the program'
	exit 1
else
	#echo Do You have installed program named finger \(yes\/no\)
	#read var
	#if [ $var == "yes" ]; then
	#	DETAILS=$(finger $USER | grep Name:)
	#	echo $DETAILS
	#elif [ $var == "no" ]; then
	#	sudo apt-get install finger
	DETAILS=$(getent passwd| grep $USER | cut -d : -f 5)
	echo $USER
	echo $DETAILS
	#else
	#	echo Wrong answer. See that. #that function
	#fi
fi
	
