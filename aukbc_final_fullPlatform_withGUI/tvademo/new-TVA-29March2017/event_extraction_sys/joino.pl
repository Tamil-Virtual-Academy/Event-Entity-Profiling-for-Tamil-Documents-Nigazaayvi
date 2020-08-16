#!/usr/bin/perl

open(F,$ARGV[0]);

while(<F>)
{
	chomp($_);
	if($_=~/^\s*$/)
	{
		print"\n";
		next;
	}
	@a=split(/\s+/,$_);

	$a[8]="O";
	#$a[4]="o";
	#$a[5]="o";
	#$a[6]="o";
	#$a[7]="o";
	#print "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\t$a[5]\t$a[6]\t$a[7]\t$a[9]\t$a[8]\n";		
	print "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\t$a[5]\t$a[6]\t$a[7]\t$a[8]\n";		
}

close(F);
