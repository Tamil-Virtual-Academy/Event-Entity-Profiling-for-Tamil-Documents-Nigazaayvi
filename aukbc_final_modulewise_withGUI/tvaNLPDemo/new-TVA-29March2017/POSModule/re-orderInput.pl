#!/usr/bin/perl

while(<>) {
	chomp;
	
	s/^\s*//;
	s/\s*$//;

	if($_ =~ /^\s*$/) {
		print "\n";
	}else{
		@elements = split(/\t/,$_);
		print "$elements[0]\n";
	}
}

