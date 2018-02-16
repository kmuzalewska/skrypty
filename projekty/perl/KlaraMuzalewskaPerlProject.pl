#!/usr/bin/perl
#Klara Muzalewska

use utf8;
binmode(STDOUT, ":utf8");

@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;

sub help(){
	print "\nProgram napisany przez Klare Muzalewska.\n";
	print "Program sluzy do tworzenia pliku pdf na podstawie istniejacego pliku txt bez formatowania.\n";
	print "Program pozwala na bardzo podstawowe formatowanie. \n";
	print "Na poczatku program prosi o wpisanie autora i tytulu formatowanego tekstu (po kazdym wpisaniu odpowiedzi nalezy wpisac enter).\n";
	print "Po kazdym przetworzonym akapicie program w linii polecen pyta o sposob formatowania.\n";
	print "Możliwe opcje to nowa linia, nowy rozdzial i separator w formie kilku gwiazdek po akapicie. \n";
	print "Aby wybrac opcje nalezy wpisac litere ktora oznacza dana opcje. Mozna wcisnac przycisk enter jako opcje domyślną, czyli opcja\n";
	print "nowej linii.\n";
	print "Jedynie na poczatku formatowania dostajemy mozliwosc nowego rozdzialu lub separator w formie kilku gwiazdek.\n";
	print "Opcja domyslna to nowy rozdzial.\n";
	print "\n\n";
	print "Jako argumenty podajemy plik txt, który chcemy sformatować do pliku pdf. Jeśli podane zostanie więcej plikow do\n";
	print "formatowania program bierze pod uwage tylko pierwszy podany plik. \n";
	print "Z jednego pliku txt powstaje jedent plik pdf (procz pobocznych plikow powstalych przez pakiet latex). \n";
	print "Plik podawany musi miec rozszerzenie txt.\n";
	print "W razie problemow w tekscie w ramach znakow specjalnych latexa program informuje o tym uzytkownika.\n";
	print "\n\n";
	print "Wykorzystywane jest oprogramowanie latex przy użyciu typu dokumentu: ksiazka.\n";
	print "Aby program dzialal poprawnie powinien byc zainstalowany podstawowy pakiet latex.\n";
}

sub interactionWithBookUser(){
	local($promptString,$defaultValue) = @_;

    print "Enter separator: [ $defaultValue ]: \n";
    print "a) \\\\ - new line\n";
    print 'b) \chapter{} - it create new chapter.';
    print "\n";
    print 'c)\begin{center}*****\end{center}- it create sepatation with stars between text.';
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
    print 'a) \chapter{}- it create new chapter';
    print "\n";
    print 'b) \begin{center}*****\end{center}- it create sepatation with stars between text' ;
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
	 	exit();
	} unless ( @arguments[$var] =~ /^-/) {
		push @files, @arguments[$var];
	}
}


# for (my $var = 0; $var < ($#files+1); $var++) {
my $filename = $ARGV[0];
print "Name of file: $filename\n";

my $baseNamefile= substr($filename, rindex($filename,"/")+1, length($filename)-rindex($filename,"/")-1);
my $fileToWrite= substr($baseNamefile, 0, rindex($baseNamefile,".")) .  ".tex";# length($baseNamefile)-rindex($baseNamefile,"/")-1);
my $pdfFile= substr($baseNamefile, 0, rindex($baseNamefile,".")) .  ".pdf";
if (-e $pdfFile){
	my $existed=1;
	my $write_secs_beggin = (stat($pdfFile))[9];
}
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
	# 		last;$write_secs
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
	system("pdflatex $fileToWrite >/dev/null </dev/null");
	
	$write_secs_end = (stat($pdfFile))[9];
	if ($existed) {
		if ($write_secs_end eq $write_secs_beggin){
			print "Program had problem with creating pdf from file. There is some probem in the text. \n";
			print "Check the content of the text. There is probably a problem with some spetial characters from latex.\n ";
			print "You can check it with special software like TexMaker.\n";
		}else{
			print "Pdf had been sucessfully created.\n";
		}
	}else{
		if (-e $pdfFile){		
			print "Pdf had been sucessfully created.\n";
		}else{
			print "Program had problem with creating pdf from file. There is some probem in the text. \n";
			print "Check the content of the text. There is probably a problem with some special characters from latex.\n ";
			print "You can check it with special software like TexMaker.\n";
		}
	}
} else {
    warn "Could not open file '$filename' $!\n";
}

# }