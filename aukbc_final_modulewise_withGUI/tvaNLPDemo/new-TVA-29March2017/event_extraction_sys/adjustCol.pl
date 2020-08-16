#!/usr/bin/perl

while(<>) {
	chomp;

	if($_ =~ /^\s*$/) {
		print "\n";
	}else{
		$_ =~ s/^\s*//;
		$_ =~ s/\s+/\t/;
		print "Doc1\t$_\n";
	}
}
