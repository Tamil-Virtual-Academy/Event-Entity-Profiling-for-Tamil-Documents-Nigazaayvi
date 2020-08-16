#!/usr/bin/perl

while(<>) {
	chomp;

	if($_ =~ /ulYlYa\tJJ/) {
		$_ =~ s/JJ\s*/V_VM_VNF_RP/;
		print "$_\n";
	}else{
		print "$_\n";
	}
}
