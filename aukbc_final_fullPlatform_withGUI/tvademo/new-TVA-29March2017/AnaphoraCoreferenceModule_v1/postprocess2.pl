#!/usr/bin/perl

open(RE1,$ARGV[0]);
while(<RE1>) {
	chomp;
	$ddHash{$_}++;
}
close(RE1);


undef @array;
open(RE2,$ARGV[1]);
while(<RE2>) {
	chomp;

	if($_ =~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		push(@array,$_);
	}
}
close(RE2);

sub process {
	@temp = split(/<dim>/,$_[0]);

	@temp_1 = split(/\s+/,$temp[0]);
	@temp_2 = split(/\s+/,$temp[1]);

	if((exists $ddHash{$temp_1[2]}) && (exists $ddHash{$temp_2[2]})) {
		if(($temp_1[0] - $temp_2[0]) < 3) {
			#print "$temp[0]\n$temp[1]\n\n";
			print join "\n", @array,"\n";
		}
	}else{
		print join "\n", @array,"\n";
	}
}
