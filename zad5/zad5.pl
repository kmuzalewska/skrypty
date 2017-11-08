#!/usr/bin/perl
#Klara Muzalewska

# Moj program procz tego co jest w specyfikacji zezwala na ustawianie flag w dowolnym miejscu w czasie wywoływania programu. 
# Nie przeszkadza mu również powtarzanie flag. Błędne flagi powodują wyświetlenie odpowiedniego komunikatu i wyjście z programu.
# Poprawnych opcji może być nieskończenie wiele.
# Połączenie opcji -n -c powoduje wyświetlenie odpowiedniego komunikatu i wyjście z programu.
# Jeśli wyświetlamy więcej niż jeden plik to zawartość poprzedzona jest nazwą pliku.
# Jeśli podana nazwa pliku jest niepoprawna to po odpowiednim komunikacie następuje wyjście z programu.


@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;
$Nflag = 0;
$cflag = 0;
$nflag = 0;
$pflag = 0;
$lines = 1;
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
	} elsif (@arguments[$var] =~ /^-/ ) {
		print "Wriong option.\n Avaliable:\n -N\n -n\n -p\n -c\n";
		exit;
	} unless ( @arguments[$var] =~ /^-/) {
		push @files, @arguments[$var];
	}
}

$nrOfFlag = $Nflag + $cflag +$nflag + $pflag;

if ($nrOfFlag == 0) {
	while (<>) {
 			print;
 	}	
 	exit;
} elsif ($nrOfFlag == 1) {
 	if ($Nflag == 1) {
 		@ARGV = @files;
		while (<>) {
	        print "$_" unless /^#/;;
		}
	} elsif ($cflag == 1 || $nflag == 1){
 		@ARGV = @files;
 		while (<>) {
 			print "$. : $_";# unless /^#/;
		}
	} elsif ($pflag == 1 ){
		@ARGV = @files;
		for (my $var = 0; $var < ($#files+1); $var++) {
			my $filename = $ARGV[$var];
			print "Name of file: $filename";
			print "\n";
		    if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
		      while (my $row = <$fh>) {
		        chomp $row;
		        print "$. : $row\n";
		      }
		    } else {
		      warn "Could not open file '$filename' $!";
		      exit;
		    }
		}
	}
} elsif ($nrOfFlag == 2 && $Nflag == 1 && $cflag == 1) {
	@ARGV = @files;
 	while (<>) {
 		print "$. : $_" unless /^#/;
	}
} elsif ($nflag == 1 && $cflag == 1){
	print "Wrong flags. Choose: -n or -c\n";
	exit;

} elsif ($nrOfFlag == 2 && $Nflag == 1 && $nflag == 1) {
	@ARGV = @files;
 	while (<>) {
 		print "$. : $_";
 		$lines++;
	}
} elsif ($Nflag == 1 && $pflag == 1 && $nflag == 0) {
	@ARGV = @files;
	for (my $var = 0; $var < ($#files+1); $var++) {
		my $filename = $ARGV[$var];
		print "Name of file: $filename";
		print "\n";
	    if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
	    while (my $row = <$fh>) {
	        chomp $row;
	        print "$. : $row\n" unless ($row =~ /^#/);
	      }
	    } else {
            warn "Could not open file '$filename' $!";
            exit;
	    }
	}
} elsif ($Nflag == 1 && $pflag == 1 && $nflag == 1) {
	@ARGV = @files;
	for (my $var = 0; $var < ($#files+1); $var++) {
		my $filename = $ARGV[$var];
		print "Name of file: $filename";
		print "\n";
	    if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
	    while (my $row = <$fh>) {
	        chomp $row;
	        unless ($row =~ /^#/) {
	        	print "$lines : $row\n";
	        	$lines++;
	        }
	      }
	      $lines = 1;
	    } else {
            warn "Could not open file '$filename' $!";
            exit;
	    }
	}
}


