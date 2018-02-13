#!/usr/bin/perl
#Klara Muzalewska

use utf8;
binmode(STDOUT, ":utf8");

@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;

sub help(){
	print "\nProgram napisany przez Klare Muzalewska.\n";
	print "Program sluzy do tworzenia pliku pdf na podstawi istniejacego pliku txt za pomoca oprogramowania latex przy użyciu typu dokumentu: ksiazka.\n";
	print "Jest mozliwosc bardzo podstawowego formatowania. Opcje sa podawane co paragraf. \n";
	print "Aby program dzialal poprawnie powinien byc zainstalowany podstawowy pakiet latex.\n";
}


sub interactionWithBookUser(){
	local($promptString,$defaultValue) = @_;

    print "Enter separator: [ $defaultValue ]: \n";
    print "a) \\\\ \n";
    print 'b) \chapter{}';
    print "\n";
    print 'c)\begin{center}*****\end{center}';
    print "\n";
    print 'q) Create pdf with texts from origin text but no more formating.';
    print "\n";

   	$| = 1;               # force a flush after our print
   	$_ = <STDIN>;         # get the input from STDIN (presumably the keyboard)

	chomp;
    return $_ ? $_ : $defaultValue;    # return $_ if it has a value

}
sub interactionWithBeginningkUser() {
	local($promptString,$defaultValue) = @_;

    print "Enter separator: [ $defaultValue ]: \n";
    print 'a) \chapter{}';
    print "\n";
    print 'b) \begin{center}*****\end{center}' ;
    print "\n";
    print 'q) Create pdf with texts from origin text but no more formating.';
    print "\n";

   	$| = 1;               # force a flush after our print
   	$_ = <STDIN>;         # get the input from STDIN (presumably the keyboard)

	chomp;
    return $_ ? $_ : $defaultValue;    # return $_ if it has a value
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
		# while (1) {
		# 	print "What type of document: \n a) book \n b) article\n";
		# 	$type = <STDIN>;
		# 	if ($type == 'a'){
		# 		$header="book.txt";
		# 		last;
		# 	} elsif ($type == 'b'){
		# 		$header="article.txt";
		# 		last;
		# 	} else{
		# 		print "Wrong option.";
		# 	}	
		# }
		$header="book.txt";
		if (open(my $head, '<:encoding(UTF-8)', $header)) {
			while (my $row = <$head>) {
				undef @words;
		        chomp $row;
		        print FILE "$row\n";
	    	}
		}
		print "Author:\n";
		print FILE '\author{';
		$author = <STDIN>;
		print FILE "$author}\n";
		print "Title:\n";
		print FILE '\title{';
		$title = <STDIN>;
		print FILE "$title}\n";
		print FILE '\begin{document}';
		print FILE '\maketitle';
		print FILE "\n";
		$quit=0;
		$begin=1;
        if($begin){
        	$begin=0;
        	while (1) {
				$option = &interactionWithBeginningkUser("Enter separator:", "a"); #"Enter separator:"
				if ($option eq 'a'){
					print FILE '\chapter{';
					print "Chapter's title:";
					$chapter = <STDIN>;
					print FILE "$chapter}\n";
					last;
				} elsif ($option eq 'b'){
					print FILE '\begin{center}*****\end{center}';
					last;
				}elsif ($option eq 'q'){
					$quit=1;
					last;
				} else{
					print "\nWrong option.\n";
				}	
			}
        }
		while (my $row = <$fh>) {
			undef @words;
	        chomp $row;
	        if ($quit) {
	        	print FILE "$row\n";
	        } else{
		        print "Paragraph:\n";
	    		print $row;
	    		print "\n";
	    		print FILE "$row\n";
	    		while (1) {
					$option = &interactionWithBookUser("Enter separator:", "a"); #"Enter separator:"
					if ($option eq 'a'){
						print FILE "\\\\";
						last;
					} elsif ($option eq 'b'){
						print FILE '\chapter{';
						print "Chapter's title:";
						$chapter = <STDIN>;
						print FILE "$chapter}\n";
						last;
					} elsif ($option eq 'c'){
						print FILE '\begin{center}*****\end{center}';
						last;
					}elsif ($option eq 'q'){
						$quit=1;
						last;
					} else{
						print "\nWrong option.\n";
					}	
				}
		        print "\n";
		    }
		}
	    print FILE '\end{document}';
	    close FILE;
	} else {
	    warn "Could not open file '$filename' $!\n";
	}
	exec("pdflatex $fileToWrite");
}print FILE '\begin{center}*****\end{center}';