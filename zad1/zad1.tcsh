#!/bin/tcsh
#Klara Muzalewska

#set USERNAME=`id -u -n`	
set q=0
set v=0

foreach i ($*)
	if ( $i == "--help" | $i == "-h" ) then
 			echo
			echo 'Program is created by Klara Muzalewska to display the login, name and surname of the current user.'
			echo
			echo 'Possible parameter:'
			echo
			echo '	./(FILENAME) 			Displays the login, name and surname of the current user'
			echo '	./(FILENAME) -h 	--help	Displays the possible options of the program'
			echo '	./(FILENAME) -q 	--quit	Ends the program'
 			exit 0
 		else if ( $i == "--quit" | $i == "-q" ) then
			set q=1 
			continue
		else
			#echo pp
			set dif=`echo $i | cut -c1`
			#echo $dif
			set dif2=`echo $i | cut -c1,2`
			if ( $dif == "-" | $dif2 == "--" ) then
				set v=1
				continue
			endif
	endif
end

if ( $q == 1 ) then
	exit 0
else if ( $v == 1 ) then
	echo $i, wrong parameter, see: 
	echo
	echo 'Program is created by Klara Muzalewska to display the login, name and surname of the current user.'
	echo
	echo 'Possible parameter:'
	echo
	echo '	./(FILENAME) 			Displays the login, name and surname of the current user'
	echo '	./(FILENAME) -h 	--help	Displays the possible options of the program'
	echo '	./(FILENAME) -q 	--quit	Ends the program'
	exit 1
else
	#echo Do You have installed program named finger \(yes\/no\)
	#read var
	#if ( $var == "yes" ); then
	#	DETAILS=$(finger $USER | grep Name:)
	#	echo $DETAILS
	#elif ( $var == "no" ); then
	#	sudo apt-get install finger
	set DETAILS=`getent passwd| grep $USER | cut -d : -f 5`
	echo Login: $USER
	echo Name: $DETAILS
	#else
	#	echo Wrong answer. See that. #that function
	#fi
endif
	
