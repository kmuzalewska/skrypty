#!/usr/bin/perl
#Klara Muzalewska
use List::Util qw(sum);

@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;
sub mean {
    return sum(@_)/@_;
}
my %grades = (
	"2+" => 2.25,
	"+2" => 2.25,
	"3+" => 3.25,
	"+3" => 3.25,
	"4+" => 4.25,
	"+4" => 4.25,
	"5+" => 5.25,
	"+5" => 5.25,
	"2-" => 1.75,
	"-2" => 1.75,
	"3-" => 2.75,
	"-3" => 2.75,
	"4-" => 3.75,
	"-4" => 3.75,
	"5-" => 4.25,
	"-5" => 4.75,
);


for (my $var = 0; $var < ($#ARGV+1); $var++) {
	my %registerToPrint;
	my %registerToCount;
	my @meanR;
	my $filename = $ARGV[$var];
    if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
       	while (my $row = <$fh>) {
	        chomp $row;
	        my @line = split ' ', $row;
	        my $name = ucfirst(lc($line[0]));
	        my $surname = ucfirst(lc($line[1]));
	        $ar = "$surname $name";
	        if (1.75 <= $line[2] && $line[2] <= 5.25) {
	        	push( @{ $registerToPrint { $ar } }, $line[2]); 
	        	push( @{ $registerToCount { $ar } }, $line[2]); 
	        }elsif ($line[2] =~ /^([+-][2-5])|([2-5][+-])$/) {
	        	push( @{ $registerToPrint { $ar } }, $line[2]); 
	        	push( @{ $registerToCount { $ar } }, $grades{$line[2]}); 

	        }else{
	        	print "I got $line[2]. Number has bad format.\n"; 
	        }
	     }
	    print "\n$filename\n";
	    for $names ( keys %registerToPrint ) {
    		print "$names: @{ $registerToPrint{$names} } : ";
    		$meanV = mean(@{ $registerToCount{$names} });
    		printf("%.2f", $meanV);
    		push @meanR, $meanV;
    		print "\n";
		}
		printf("Srednia ocen w calym pliku: %.2f\n", mean(@meanR));
	 } else{
	 	warn "\nCould not open file '$filename' $!";
	 }
}
