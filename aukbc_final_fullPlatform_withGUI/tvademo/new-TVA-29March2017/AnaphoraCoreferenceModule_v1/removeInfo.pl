#!/usr/bin/perl

while(<>) {
	chomp;
	
	if($_ =~ /^\s*$/) {
		print "\n";
	}else{
		@array = split(/\s+/,$_);
		pop(@array);
		pop(@array);
		pop(@array);

		$line = join "   ", @array;
		$line =~ s/\s+$//;

		print "$line\n";
	}
}

