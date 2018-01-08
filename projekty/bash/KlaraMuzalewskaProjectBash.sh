#!/bin/bash
#Klara Muzalewska

my_dir="$(dirname "$0")"

function helpMe()
{
	echo "	
	Program napisany przez Klare Muzalewska. Jest to program implementujący autorski algorytm szyfrujący i deszyfrujący.
	Program defaultowo (bez flag) szyfruje argumenty wywolania programu wpisane przez użytkownika. 
	Rezultat zaszyfrowania argumentu jest zapisywany do pliku, ktory ma nazwe orginalna z dopiskiem encrypt. Kod uzywa angielskiego alfabetu. Mozna wprowadzac liczby i znaki: ".,". 
	Program obsługuje flage -h lub --help, która pokazuje możliwe opcje jak i cel programu.
	Możliwe flagi to rowniez -e --encryption, która robi to samo co defaultowa wersja
				-d --decryption , która rozszyfrowuje podany tekst.
				-ha --helpAlgorithm , która wyjasnia dzialanie algorytmu szyfrujacego.
	Mozliwe jest równiez szyfrowanie calych plikow flagami -f lub --file. Wpisuje sie je jako argumenty wywolywania programu.
	Jezeli podane zastana nieprawidlowy plik, to program podaje odpowiedni komunikat i przechodzi do nastepnego podanego pliku.
	Domyslnie rezultat zaszyfrowania lub deszyfrowania pliku ma nazwe orginalna z dopiskiem decrypt lub encrypt w zaleznosci od 
	czynnosci ktory program wykonywal.
	Flag szyfrowania i deszyfrowania nie mozna laczyc.
	Jezeli podane flagi sa niepoprawne to progam sie konczy i wychodzi.
	Znaki i litery specjalne sa z tekstu usuwane.
	"
}

function algorithm()
{
	echo "
	Sposob szyfrowania wyrazu: pierwszej litery sie nie szyfruje. Jest ona srodkowa litera zaszyfrowanego wyrazu. Kolejne litery sa 
	szyfrowane w taki sposob ze jedna litera jest przedstawiana przez dwie, w taki sposób, ze wpisuje sie po obu stronach srodkowej litery, 
	czyli symetrycznie wzgledem litery srodkowej.
	Wyraz 'ale' bylby zaszyfrowany tak, ze 'a' jest srodkowa litera nastepnie 'l' jest dzielona na 2 i wystepuje po dwoch stronach 'a',
	czyli 'pierwszy_czlon_l'a'drugi_czlon_l'. W ten sam sposob wstawiamy 'e' i wychodzi: 'pierwszy_czlon_e''pierwszy_czlon_l'a'drugi_czlon_l''drugi_czlon_e'.
	W jaki sposob tworzy sie czlony litery:
	kazda litera do zaszyfrowania ma swoj numer od 2 do 27 (alphabetToCreate). Losujemy numer od 1 do numeru danej liczby pomniejszonej o jeden 
	(gdybysmy szyfrowali 'c' to losowalibysmy od 1 2, a jesli 'l' to od 1 do 11).
	Ten numer odpowiada literze w alfabecie ('a' to 1, 'b' to 2 itd.). Ta litera to pierwszy czlon litery do zaszyfrowania.
	Ten wylosowany numer odejmujemy od numeru przyporządkowanego do litery, którą chcielismy zaszyfrowac. Wynik odejmowania jest pozycja drugiego czlonu litery do zaszyfrowania.
	Przyklad: 'ale' : 'pierwszy_czlon_e''pierwszy_czlon_l'a'drugi_czlon_l''drugi_czlon_e'
		'l': (czyli 12)
		losujemy z przedzialu: 1-11 - zalozmy ze dostajemy 7. 7 odpowiada 'g'.
		12-7=5 czyli 'e'.
		mamy 'pierwszy_czlon_e'gae'drugi_czlon_e'
		'e': (czyli 5)
		losujemy z przedzialu: 1-4 - zalozmy ze dostajemy 2. 2 odpowiada 'b'.
		5-2=3 czyli 'c'
		dostajemy bgaec.

	"
}

function wordMake()
{
	var=$(echo "$1" |sed 's/[^a-z  A-Z 0-9 .,]//g')
	echo "$var"
	 
}

nrOfFlag=0
flagEn=0
flagDe=0
flagFile=0
content=()

for i in $@
do
	case $i in
		-h| ---help )
			helpMe
			exit 0
			;;
		-e| --encrypt )
			flagEn=1
			;;
		-d| --decrypted )
			flagDe=1
			;;
		-f| --file )
			flagFile=1
			# echo filed
			;;
		-ha| --helpAlgorithm )
			algorithm
			exit 0
			;;
		\-* )
			echo "Wrong option"
			exit 1
			;;
		* )
			content+=($i)
			;;
		esac
done

nrOfFlag=$(expr $flagEn + $flagDe)
if [[ $nrOfFlag == 2 ]]; then
	echo "Wrong combination of flags."
	exit 1
fi

if [[ $flagFile == 1 ]]; then
	if [[ $flagDe == 1 ]]; then
		for i in ${!content[*]}; do
			filename="${content[$i]}"
			if ! [ -e $filename ]; then
				echo "File do not exist"
				continue
			fi
			sed -i -e '$a\' $filename
			while read line; do
				if [[ -z "$line" ]]; then
					echo >> ${filename%.*}_decrypt.txt
				else
					for word in $line; do
	        			properW=$(wordMake $word)
	        			echo -n "$($my_dir/decrypt.sh $properW) " >> ${filename%.*}_decrypt.txt
	    			done
	    			echo  >> ${filename%.*}_decrypt.txt
	    		fi
			done < ${content[$i]}
		done
	else
		for i in ${!content[*]}; do
			filename="${content[$i]}"
			if ! [ -e $filename ]; then
				echo "File do not exist"
				continue
			fi
			sed -i -e '$a\' $filename
			while read line; do
				if [[ -z "$line" ]]; then
					echo >> ${filename%.*}_ecrypt.txt
				else
					for word in $line; do
	        			properW=$(wordMake $word)
	        			echo -n "$($my_dir/encrypt.sh $properW) " >> ${filename%.*}_ecrypt.txt
	    			done
	    			echo >> ${filename%.*}_ecrypt.txt
	    		fi
			done < ${content[$i]}
		done
	fi
else
	if [[ $flagDe == 1 ]]; then
		for i in ${!content[*]}; do
			properW=$(wordMake ${content[$i]})
			$my_dir/decrypt.sh $properW >> ${content[$i]}_decrypt.txt
		done
	else
		for i in ${!content[*]}; do
			properW=$(wordMake ${content[$i]})
			$my_dir/encrypt.sh $properW >> ${content[$i]}_encrypt.txt
		done
	fi

fi