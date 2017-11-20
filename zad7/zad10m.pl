#!/usr/bin/perl
#Klara Muzalewska

use rgx;
@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;
#$nrOfWordsInOneLine = 0;
$bflag = 0;
$wflag = 0;
$dflag = 0;
$iflag = 0;
$lflag = 0;
$lines = 0;
$words = 0;
$bytes = 0;
$digits = 0;
$intigers = 0;
$totalNrOfWords = 0;
$totalNrOfLines = 0;
$totalNrOfBytes = 0;
$totalNrOfIntigers = 0;
$nrOfFlag =0;


my @files;
for (my $var = 0; $var < $nrOfArguments ; $var++) {
	if (@arguments[$var] eq "-d" ) {
	 	$dflag = 1;
	} elsif (@arguments[$var] eq "-i") {
	 	$iflag = 1;
	} elsif (@arguments[$var] eq "-w") {
		$wflag = 1;
	} elsif (@arguments[$var] eq "-c") {
		$bflag = 1;
	} elsif (@arguments[$var] eq "-l") {
		$lflag = 1;
	} elsif (@arguments[$var] =~ /^-/ ) {
		print "Wriong option.\n Avaliable:\n -d\n -i\n -w\n -c\n -l\n";
		exit;
	} unless ( @arguments[$var] =~ /^-/) {
		push @files, @arguments[$var];
	}
}


$nrOfFlag = $bflag + $wflag + $dflag + $iflag + $lflag;

@ARGV = @files;
for (my $var = 0; $var < ($#files+1); $var++) {
	my $filename = $ARGV[$var];
	#print "Name of file: $filename";
#		print "\n";
    if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
      	while (my $row = <$fh>) {
	        chomp $row;
	        $lines++;
	        my @text_words = split(/\s+/, $row);
	        $words += $#text_words+1;
			for my $var (@text_words){
				if (rgx::ifIntigers($var) == 1){
					$intigers++;
				}
				if (rgx::ifDigit($var) == 1){
					$digits++;
				}
			}
	    }
	    $bytes = -s $filename;
	    if ($nrOfFlag == 0){
	    	print "$lines\t $words\t $bytes\t $filename\n";
    	}else {
    		if($bflag == 1){
    			print "$bytes\t";
    		}
    		if ($wflag == 1 ){
    			print "$words\t";
    		}	
    		if ($lflag == 1){
    			print "$lines\t";
    		}
    		if ($iflag == 1){
    			print "$intigers\t";
    		}
    		if ($dflag == 1){
    			print "$digits\t";
    		}
    		print "$filename\n";
    	}
    } else {
    	warn "Could not open file '$filename' $!";
	    exit;
    }
    $totalNrOfBytes+=$bytes;
    $totalNrOfLines+=$lines;
	$totalNrOfWords+=$words;	
	$totalNrOfIntigers+=$intigers;
	$totalNrOfDigits+=$digits;
    $words = 0;
    $lines =0;
    $bytes = 0;
    $intigers =0;

}
if (($#files+1) > 1 ) {
    if ($nrOfFlag == 0){
		print "$totalNrOfLines\t $totalNrOfWords\t $totalNrOfBytes\t total\n";
	}else {
		if($bflag == 1){
			print "$totalNrOfBytes\t";
		}
		if ($wflag == 1 ){
			print "$totalNrOfWords\t";
		}	
		if ($lflag == 1){
			print "$totalNrOfLines\t";
		}
		if ($iflag == 1){
    		print "$totalNrOfIntigers\t";
    	}
    	if ($dflag == 1) {
    		print "$totalNrOfDigits\t";
    	}
		print "total\n";
	}
}
