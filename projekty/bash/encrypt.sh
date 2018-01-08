#!/bin/bash
#Klara Muzalewska

declare -A alphabet_a_twentyseven

alphabet_a_twentyseven=(
['b']=2
['c']=3
['d']=4
['e']=5
['f']=6
['g']=7
['h']=8
['i']=9
['j']=10
['k']=11
['l']=12
['m']=13
['n']=14
['o']=15
['p']=16
['q']=17
['r']=18
['s']=19
['t']=20
['u']=21
['v']=22
['w']=23
['x']=24
['y']=25
['z']=26
['a']=27
['A']=28
['B']=29
['C']=30
['D']=31
['E']=32
['F']=33
['G']=34
['H']=35
['I']=36
['J']=37
['K']=38
['L']=39
['M']=40
['N']=41
['O']=42
['P']=43
['Q']=44
['R']=45
['S']=46
['T']=47
['U']=48
['V']=49
['W']=50
['X']=51
['Y']=52
['Z']=53
['1']=54
['2']=55
['3']=56
['4']=57
['5']=58
['6']=59
['7']=60
['8']=61
['9']=62
['0']=63
[',']=64
['.']=65
)


alphabet_a_one_array=( begin a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9 0 , \.)


word=("$1")
declare -a wordArray
first=''
second=''
rev=''
i=1
while [ $i -lt ${#word} ]; do wordArray[$i]=${word:$i:1};  i=$((i+1));done # 
for ix in ${!wordArray[*]}
do
	a=${wordArray[$ix]}
	r=$(expr ${alphabet_a_twentyseven[$a]} - 1)
	random=$(shuf -i 1-$r -n 1)
	filling=`expr ${alphabet_a_twentyseven[$a]} - $random`
	first+="${alphabet_a_one_array[$random]}"
	second+="${alphabet_a_one_array[$filling]}"
done
copy=${first}
for((i=${#copy}-1;i>=0;i--)); do rev="$rev${copy:$i:1}"; done
echo $rev${word:0:1}$second
