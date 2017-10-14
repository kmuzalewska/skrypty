#!/bin/tcsh
#Klara Muzalewska

@ n= 0
@ oper= 0
@ arg1= 0

foreach i ($*)
    @ va= `echo $i | grep -Eio '^[-, 0-9][0-9]*$'`
    @ vav= `echo $i | grep -Eio -c '^s|a|m|d|p|mod$'`  
    if ( $i == "--help" | $i == "-h" ) then
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
    else if ( $va ) then
        if ( $n == 0 ) then
            set n=1
            set arg1=$i
        else if ( $n == 1 ) then
            set n=2
            set arg2=$i
        else if ( $n == 3 ) then
            continue
        endif
    else if ( $vav && $oper == 0 ) then
        set oper=1
        set operator=$i
    else if ( ! `echo $i | grep -Eio '^[0-9]+[\.0-9]$'` ) then
        echo Bad numbers
        exit 1
    else
        echo 'Bad operators. Possible operators:'
        echo '              s substitution'
        echo '              a adding'
        echo '              m multiplication'
        echo '              d division'
        echo '              p power'
        echo '              mod modulo'
        exit 2
    endif
end

if ( $n == 2  && $oper == 1 ) then
    if ( "$arg1" > "$arg2" ) then
        set i = "$arg1"
        @ k=$arg2 - 1
        while ( "$i" > "$k" )
            set j = $arg1
            while ( "$j" > "$k" )
                if ( $operator == "s" ) then
                    @ result= $i - $j
                    printf "| %3s " $result
                else if ( $operator == "a" ) then
                    @ result= $i + $j
                    printf "| %3s " $result
                else if ( $operator == "m" ) then
                    @ result= $i * $j
                    printf "| %3s " $result
                else if ( $operator == "d" ) then
                    @ result= $i / $j
                    printf "| %3s " $result
                else if ( $operator == "p" ) then
                    @ result= $i ** $j
                    printf "| %3s " $result
                else if ( $operator == "mod" ) then
                    @ result= $i % $j
                    printf "| %3s " $result
                endif
                @ j-=1 ;
             end
                echo "|"
                @ i-=1 ;
        end
    else
        foreach i ( `seq $arg1 $arg2` )
            foreach j ( `seq $arg1 $arg2` )
                 if ( $operator == "s" ) then
                    @ result= $i - $j
                    printf "| %3s " $result
                else if ( $operator == "a" ) then
                    @ result= $i + $j
                    printf "| %3s " $result
                else if ( $operator == "m" ) then
                    @ result= $i * $j
                    printf "| %3s " $result
                else if ( $operator == "d" ) then
                    @ result= $i / $j
                    printf "| %3s " $result
                else if ( $operator == "p" ) then
                    @ result= $i ** $j
                    printf "| %3s " $result
                else if ( $operator == "mod" ) then
                    @ result= $i % $j
                    printf "| %3s " $result
                endif
            end
            echo "|"
        end
endif
