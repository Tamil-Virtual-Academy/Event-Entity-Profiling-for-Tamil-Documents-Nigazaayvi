#!/usr/bin/perl

while(<>) {
	chomp;
	if($_ =~ /^\s*$/) {
		print "\n";
		next;
	}
	@temp = split(/\s+/,$_);
	print "$temp[0]\t$temp[1]\t$temp[2]\t$temp[3]\t$temp[4]\t$temp[5]\t$temp[6]\t$temp[8]\n";
}
