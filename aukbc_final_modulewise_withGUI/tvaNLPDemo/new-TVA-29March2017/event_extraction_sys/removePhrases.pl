#!/usr/bin/perl

undef @array;

while(<>) {
	chomp;
	
	if($_ =~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		push(@array,$_);
	}
}

sub process {
	$verbF = 0;

	foreach $k (@array) {
		if($k =~ /\s+V_/) {
			$verbF = 1;
		}
	}

	if($verbF == 1) {
		print join "\n", @array,"\n";
	}
}
