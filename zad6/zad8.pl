#!/usr/bin/perl
#Klara Muzalewska

# Aby program działał poprawnie z separatoram w postaci znaku specjalnego musi dostać znak spacjalny podany w poprawny sposób
# czyli poprzedzony znakiem \ . Innym sposobem na to jest podanie takiego separatora w cudzysłowie.
# Aby separatorem była gwiazdka nalezy ją podać jako: \* lub "*" lub '*'
# Aby separatorem był nawias nalezy go podać jako: \( lub  "(" lub '*'
# itd.

@arguments = @ARGV;

$nrOfArguments = $#ARGV+1;

$separator= @arguments[0];
if (@arguments[1] =~ /^[+]?\d+$/ ) {
	$firstNumber= @arguments[1];
	#print $firstNumber;
}
if (@arguments[2] =~ /^[+]?\d+$/ ) {
	$secondNumber= @arguments[2];
}
unless ($firstNumber && $secondNumber) {
	print "Wrong numbers\n";
	exit 1;
}elsif ($firstNumber > $secondNumber) {
	($firstNumber, $secondNumber) = ($secondNumber, $firstNumber);
} 
#print "Separator: $separator\n First number: $firstNumber\n Second number: $secondNumber\n";
#print "$firstNumber\n";
#print "$secondNumber\n";


@files=@arguments[3..$#arguments+1];
@ARGV = @files;
for (my $var = 0; $var < ($#files); $var++) {
	my $filename = $ARGV[$var];
	#print "Name of file: $filename\n";
	if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
		while (my $row = <$fh>) {
			undef @words;
	        chomp $row;
	        my @words = split " ", $row;
	        #print "$#words\n";
	        $diffrence = $secondNumber-$firstNumber;
	        if (($#words+1) < $diffrence) {
	        	#print "$diffrence\n";
	        	@subarray = @words[$firstNumber-1..$#words+1];
	        	#print "@subarray\n";
	        }else{
	        @subarray = @words[$firstNumber-1..$secondNumber-1];
	    	}
	        $string = join ( "$separator", @subarray );
	        print $string;
	        print "\n";
	    }
	} else {
	    warn "Could not open file '$filename' $!\n";
	}
}
	


