#!/usr/bin/perl -w

use strict;
use warnings;
use JSON;
use Data::Dumper;

print ("\nrunning\n");

my $dir="./files_to_process";
my $type = "txt";
my %hashObject;
my @hashObjectArray = [];


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
	# Process mode codes
	# 0 - not processing
	# 1 - looking for keys
	# 2 - looking for values
	my $size = @_;
	if ($size > 1) {
		print "size is too large for sub readOneFile. Max args is 1.\n";
	}
	my $fileName= $_[0];
	open(FH, "<","$fileName") or die $!,": fileName is $fileName";
	while(<FH>){ #loop through every line
		my $check_for_trash_chars = 0;
		my $keep_checking_line = 1;
		#print "$_\n";
		my $line = $_;
		if ($process_mode == 0) {
			# check to see if the line contains only spaces and two "=" in a row
			if ($keep_checking_line == 1) {
				my $eqCounter = 0;
				foreach my $char (split('',$line)) {
					if ($keep_checking_line == 1 && $process_mode == 0) {
						#print("$char");
						if ($check_for_trash_chars == 1 && ($char ne " " && $char ne "=" && $char ne "\n")) {
							print("warning: extra characters on the separater line (the line with \"==\") are ignored.");
							print("\$char is \"$char\"");
							$check_for_trash_chars = 0;
							$keep_checking_line = 0;
							$process_mode = 1;
						}
						elsif ($char ne " " && $char ne "=") {
							$keep_checking_line = 0;
						}
						elsif ($char eq "=") {
							++$eqCounter;
							if ($eqCounter == 2) {
								#print("found separater");
								$check_for_trash_chars = 1; #we have two equal signs, time to trash rest of line.
								$process_mode = 1;
							}
						}
					}
				}
			}
		}
		# this whole line will be processed in process mode. It will start at process_mode 1, looking for keys, then it will go to process mode 2 and look for values.
		elsif ($process_mode == 1 || $process_mode == 2) {
			my $current_key = "";
			my $current_value = "";
			foreach my $char (split('', $line)){
				if ($current_key eq "/==") {
					# add the hashObject to the hashObjectArray
					push @hashObjectArray, %hashObject;
					print (Dumper \%hashObject);
					$current_value = "";
					$current_key = "";
					$process_mode = 0;
				}
				elsif ($process_mode == 1) {
					if ($char ne ":") {
						$current_key = $current_key . $char;
					}
					elsif ($char eq ":") {
						$process_mode = 2; # process mode = 2 so it will now look for values.
					}
				}
				elsif ($process_mode == 2) {
					if ($char ne "\n"){
						$current_value = $current_value . $char;	
					}
					elsif ($char eq "\n") {
						# add a key-value pair to the object.
						$process_mode = 1;
						$hashObject{$current_key} = $current_value;
						#print Dumper \%hashObject;
						$current_key = "";
						$current_value = "";
					}
				}
				last if ($process_mode == 0);
			}
			foreach my $obj ( @hashObjectArray ) {
				#print Dumper $obj;
			}
		}
	}
}
