#!/usr/bin/perl
#Klara Muzalewska


@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;
$Nflag = 0;
$cflag = 0;
$nflag = 0;
$pflag = 0;
my @files;

for (my $var = 0; $var < $nrOfArguments ; $var++) {
	if (@arguments[$var] eq "-N" ) {
	 	$Nflag = 1;
	} elsif (@arguments[$var] eq "-c") {
	 	$cflag = 1;
	} elsif (@arguments[$var] eq "-n") {
		$nflag = 1;
	} elsif (@arguments[$var] eq "-p") {
		$pflag = 1;
	} unless ( @arguments[$var] =~ /^-/) {
		push @files, @arguments[$var];
	}
}

$nrOfFlag = $Nflag + $cflag +$nflag + $pflag;
#print "$nrOfFlag\n @files\n";

if ($nrOfFlag == 0) {
	while (<>) {
 			print;
 	}	
} elsif ($nrOfFlag == 1) {
 	if ($Nflag == 1) {
 		# for (my $var = 0; $var < ($#files+1); $var++) {
		 # 	my $filename = $ARGV[$var];
		 #    if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
		 #      while (my $row = <$fh>) {
		 #        chomp $row;
		 @ARGV = @files;
 		 while (<>) {
		     	print "$row\n" unless ($row =~ /^#/);
		    #      }
		    #   }
		    # } else {
		    #   warn "Could not open file '$filename' $!";
		    # }
		}
 	} elsif ($cflag == 1 ){
 		@ARGV = @files;
 		while (<>) {
 			print "$. : $_" unless /^#/;
		}
	}
}
 
#print "$Nflag, $cflag, $nflag, $pflag\n";
# use strict;
# use warnings;
# my $max = $#ARGV+1;

# for (my $var = 0; $var < $max; $var++) {
# 	my $filename = $ARGV[$var];
# 	print $filename;
# 	print "\n";
#     if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
#       while (my $row = <$fh>) {
#         chomp $row;
#         unless ($row =~ /^#/) {
#          	print "$. : $row\n";
#          }
#       }
#     } else {
#       warn "Could not open file '$filename' $!";
#     }
# }


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

# while (<>) {
# 	# print 'ha';
# 	 #$_ zmienna domyslna '-' podepnij w to miejsce standerd input
# 	print "$. : $_" unless /^#/;
	
# }

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

