#!/bin/bash
#Klara Muzalewska

declare -A alphabet_a_one

alphabet_a_one=(
['a']=1
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
['A']=27
['B']=28
['C']=29
['D']=30
['E']=31
['F']=32
['G']=33
['H']=34
['I']=35
['J']=36
['K']=37
['L']=38
['M']=39
['N']=40
['O']=41
['P']=42
['Q']=43
['R']=44
['S']=45
['T']=46
['U']=47
['V']=48
['W']=49
['X']=50
['Y']=51
['Z']=52
['1']=53
['2']=54
['3']=55
['4']=56
['5']=57
['6']=58
['7']=59
['8']=60
['9']=61
['0']=62
[',']=63
['.']=64
)


alphabet_a_twentyseven_array=( begin begin b c d e f g h i j k l m n o p q r s t u v w x y z a A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9 0 , \. )

decrypted=''
declare -a wordArray
word=("$1")
beginning=`expr ${#word} / 2 + 1`
decrypted+=$(expr substr $word $beginning 1)
i=0
while [ $i -lt ${#word} ]; do wordArray[$i]=${word:$i:1};  i=$((i+1));done 
for (( i = $beginning-2; i >= 0; i-- )); do
	positionOfSecondPart=`expr ${#word} - $i - 1`
	sum=`expr ${alphabet_a_one[${wordArray[$i]}]} + ${alphabet_a_one[${wordArray[$positionOfSecondPart]}]} `
	decrypted+=${alphabet_a_twentyseven_array[$sum]}
done
echo $decrypted

