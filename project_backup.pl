#!/usr/bin/perl -w

use strict;
use warnings;

my $dir="./files_to_process";
opendir(DIR, $dir) || die "Error in opening dir on line 7.";
while ( (my $filename = readdir(DIR) ) ) {
    print("$filename\n") if $filename =~ /\.txt\z/ ;
}
closedir(DIR);
