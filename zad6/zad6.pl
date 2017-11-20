#!/usr/bin/perl
#Klara Muzalewska


@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;
if (@arguments[0] =~ /^[+]?\d+$/ ) {
	$firstNumber= @arguments[0];
}
if (@arguments[1] =~ /^[+]?\d+$/ ) {
	$secondNumber= @arguments[1];
}
unless ($firstNumber && $secondNumber) {
	print "Wrong numbers\n";
	exit 1;
}elsif ($firstNumber > $secondNumber) {
	($firstNumber, $secondNumber) = ($secondNumber, $firstNumber);
} 
#print "First number: $firstNumber\n Second number: $secondNumber\n";
#print "$firstNumber\n";
#print "$secondNumber\n";


@files=@arguments[2..$#arguments+1];
@ARGV = @files;
for (my $var = 0; $var < ($#files); $var++) {
	my $filename = $ARGV[$var];
	#print "Name of file: $filename\n";
	if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
		while (my $row = <$fh>) {
			undef @words;
	        chomp $row;
	        my @words = split " ", $row;
	        print @words[$firstNumber-1..$secondNumber-1];
	        print "\n";
	    }
	} else {
	    warn "Could not open file '$filename' $!\n";
	}
}
	
#drugi skrypt:
#tylko dwa słowa które padaja w argumentach
#jesni brak standard errror i przechpdze do nastepmej linii
#separator zamiast whitespacu


