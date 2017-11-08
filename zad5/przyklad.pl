#!/usr/bin/perl
#Klara Muzalewska



use strict;
use warnings;
my $max = $#ARGV+1;

for (my $var = 0; $var < $max; $var++) {
	my $filename = $ARGV[$var];
	print $filename;
	print "\n";
    if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
      while (my $row = <$fh>) {
        chomp $row;
        unless ($row =~ /^#/) {
         	print "$. : $row\n";
         }
      }
    } else {
      warn "Could not open file '$filename' $!";
    }
}


# while (<>) {
# 	unless (/^#/) {
# 			print
# 		}	
	
# }
# print ;
# print "\n";
# $nrOfArguments = ($#ARGV +1)
# if ($nrOfArguments == 0 ) {
# 	# body...
# }
# for (my $var = 0; $var < ($#ARGV +1); $var++) {
# 	# body...
# }
# while (<>) {
# 	if (!/^#/) {
# 			print
# 		}	
	
# }

# while (<>) {
# 	# print 'ha';
# 	 #$_ zmienna domyslna '-' podepnij w to miejsce standerd input
# 	print "$. : $_" unless /^#/;
	
# }
# close ;
# print " \n"
# # while (<>) { #$_ zmienna domyslna '-' podepnij w to miejsce standerd input
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

