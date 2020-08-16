#!/usr/bin/perl

open(RE,"$ARGV[0]");
while(<RE>) {
	chomp;
	push(@array1,$_);
}
close(RE);


open(RE,"$ARGV[1]");
while(<RE>) {
	chomp;
	push(@array2,$_);
}
close(RE);

for($i = 0;$i < @array2;$i++) {

	if($array1[$i] =~ /^\s*$/) {
		print "\n";
	}else{
		@temp2 = split(/\t/,$array2[$i]);
		$array1[$i] =~ s/^\s+//;
		$array1[$i] =~ s/\s+/\t/g;
		print "$array1[$i]\t$temp2[5]\t$temp2[6]\n";
	}
}
