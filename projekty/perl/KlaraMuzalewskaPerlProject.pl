#!/usr/bin/perl
#Klara Muzalewska

use utf8;
binmode(STDOUT, ":utf8");

@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;

sub help(){
	print "\nProgram napisany przez Klare Muzalewska.\n";
	print "Program sluzy do tworzenia pliku tex na podstawi istniejacego pliku txt.\n";
}


sub interactionWithUser(){
	local($promptString,$defaultValue) = @_;

	if ($defaultValue) {
	      print $promptString, "[", $defaultValue, "]: ";
	   } else {
	      print $promptString, ": ";
	   }

	   $| = 1;               # force a flush after our print
	   $_ = <STDIN>;         # get the input from STDIN (presumably the keyboard)

	   chomp;


}

my @files;
for (my $var = 0; $var < $nrOfArguments ; $var++) {
	if (@arguments[$var] eq "-h" or  @arguments[$var] eq "--help") {
	 	help();
	# } elsif (@arguments[$var] eq "-w") {
	# 	$wflag = 1;
	# } elsif (@arguments[$var] eq "-c") {
	# 	$bflag = 1;
	# } elsif (@arguments[$var] eq "-l") {
	# 	$lflag = 1;
	# } elsif (@arguments[$var] =~ /^-/ ) {
	# 	print "Wriong option.\n Avaliable:\n -d\n -i\n -w\n -c\n -l\n";
	# 	exit;
	} unless ( @arguments[$var] =~ /^-/) {
		push @files, @arguments[$var];
		# print @arguments[$var];
		# print $#files;
	}
}


for (my $var = 0; $var < ($#files+1); $var++) {
	my $filename = $ARGV[$var];
	print "Name of file: $filename\n";

	my $baseNamefile= substr($filename, rindex($filename,"/")+1, length($filename)-rindex($filename,"/")-1);
	my $fileToWrite= substr($baseNamefile, 0, rindex($baseNamefile,".")) .  ".tex";# length($baseNamefile)-rindex($baseNamefile,"/")-1);
	# print "$fileToWrite\n";
	if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
		unless(open FILE, ">:utf8", $fileToWrite) {
    		warn "\nUnable to create $file\n";
    		continue;
		}
		while (my $row = <$fh>) {
			undef @words;
	        chomp $row;
	        print FILE "$row\n";
	        # print "$row\n";	        	      
	        # print "\n";
	    }
	    close FILE;
	} else {
	    warn "Could not open file '$filename' $!\n";
	}
}