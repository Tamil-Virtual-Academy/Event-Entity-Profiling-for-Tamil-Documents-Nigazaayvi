#!/usr/bin/perl

while(<>) {
	chomp;
	
	if($_ =~ /^\s*$/) {
		print "$_\n";
	}else{
		@temp = split(/\t/,$_);

		print "$temp[0]\t$temp[1]\t$temp[2]\t$temp[3]\t$temp[4]\n";
	}
}
