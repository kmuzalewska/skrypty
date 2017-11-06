#!/usr/bin/perl

# while (<>) {
# 	unless (/^#/) {
# 			print
# 		}	
	
# }

# while (<>) {
# 	if (!/^#/) {
# 			print
# 		}	
	
# }

while (<>) { #$_ zmienna domyslna '-' podepnij w to miejsce standerd input
	print "$. : $_" unless /^#/
}
print " \n"
# while (<>) { #$_ zmienna domyslna '-' podepnij w to miejsce standerd input
# 	if !/^#/ {
# 		print
# 	}
# }
# # 	#print unless /^#/
# }

# print $. #ilosc linii

# -N nie wyrzucaj linijek zaczynajacych sie od h /^#/
# -c podaj numer linii
# -n numeruj jedynie linie pokazywane, jak widać wariant opcji -c, co robić
# w przypadku połączenia tych opcji w jednym wywołaniu należy do Państwa :-)
# -p numeruj linie osobno dla każdego z plików, zaczynając od 1 (jak skrypt
# czwarty powyżej).
## print "$. : $_"