#!/usr/bin/perl -w

use strict;
use warnings;

my $dir="./files_to_process";
my $type = "txt";

my @fileNameArray = getFileType($dir, $type);
foreach (@fileNameArray){
	#print "\$_ is $_\n";
	readOneFile("$dir/$_");
}

sub getFileType{
	# Given a dir path and a file extension, will return an array of file names.
	my $dir = $_[0];
	my $type = $_[1];
	my @fileList;
	opendir(DIR, $dir) || die "Error in opening dir. \$dir is $dir";
	while ( (my $filename = readdir(DIR) ) ) {
		if ($filename =~ /\.$type\z/) {
			push(@fileList, $filename);
		}
	}
	#print(@fileList,"\n");
	return @fileList;
	closedir(DIR);
}

sub readOneFile {
	# will return on file content, given the file name.
	my $process_mode = 0; #once system encounters multiple "=" on one line, it will turn on this mode.
	my $size = @_;
	if ($size > 1) {
		print "size is too large for sub readOneFile. Max args is 1.\n";
	}
	my $fileName= $_[0];
	open(FH, "<","$fileName") or die $!,": fileName is $fileName";
	while(<FH>){ #loop through every line
		my $keep_checking_line = 1;
		#print "$_\n";
		my $line = $_;
		if ($process_mode = 0) {
			# check to see if the line contains only spaces and two "=" in a row
			foreach my $char (split('',$line)) {
				#print("$char\n");
				if ($char ne " " || $char ne "=") {
					$keep_checking_line = 0;
				}
			}
		}
	}
}
