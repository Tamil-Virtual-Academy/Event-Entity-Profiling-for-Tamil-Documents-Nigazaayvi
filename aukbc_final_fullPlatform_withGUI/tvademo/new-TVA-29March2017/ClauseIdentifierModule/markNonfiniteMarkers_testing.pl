#!/usr/bin/perl

while(<>) {
	chomp;
	
	if($_ =~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		$_ = $_."\to";
		push(@array,$_);
	}
}

sub process {
	
	for($i = 0;$i< @array;$i++) {
		if($array[$i] =~ /V_VM_VNF_((RP)|(COND))/) {
			$tag = $1;
			$array[$i] =~ s/\to$/\t$tag/;
		}elsif(($array[$i] =~ /V_VM_VNF_VBN/) && ($array[$i+1] !~ /V_VM_VNF_/)) {
			$array[$i] =~ s/\to$/\tVBN/;
		}elsif(($array[$i] =~ /V_VM_VNF_INF/) && ($array[$i+1] !~ /V_VM_VNF_/)) {
			$array[$i] =~ s/\to$/\tINF/;
		}elsif(($array[$i] =~ /^eVnYrYu/) && ($array[$i+1] =~ /CC_CCS/)) {
			$array[$i] =~ s/\to$/\tCOM/;
		}elsif(($array[$i] =~ /V_VM_VNF_INF/) && ($array[$i+1] =~ /^ulYlYa\t/)) {
			$array[$i+1] =~ s/\to$/\tRP/;
		}elsif(($array[$i] =~ /veNtum/) && ($array[$i+1] =~ /^eVnYrYa\t/)) {
			$array[$i+1] =~ s/\to$/\tRP/;
		}elsif(($array[$i] =~ /^eVnYa/) && ($array[$i+1] =~ /CC_CCS/)) {
			$array[$i] =~ s/\to$/\tCOM/;
		}elsif($array[$i] =~ /^eVnYrYAr/) {
			$array[$i] =~ s/\to$/\tCOM1/;
		}
	}

	print join "\n", @array, "\n";
}
