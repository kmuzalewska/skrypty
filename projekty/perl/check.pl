#!/usr/bin/perl

@arguments = @ARGV;
$nrOfArguments = $#ARGV+1;

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
	print "$fileToWrite\n";
}