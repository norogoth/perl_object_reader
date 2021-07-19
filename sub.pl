#!/usr/bin/perl

use strict;
use warnings;

sub rawr {
	my ($dino, $how) = @_;
	print "$dino says 'RAWR' $how","ly.";
}


sub giveRace {
	my (%params) = @_;
	print "$params{firstname} $params{lastname} is a $params{race}. We have no data on $params{beans}";
}

giveRace(
	firstname=>"Melvin",
	lastname=>"Gorblekov",
	race=>"tielfing elf."
);
