#!/usr/bin/perl

undef @array;
undef %ddHash;
while(<>) {
	chomp;

	if($_ =~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		push(@array,$_);
	}
}

foreach $k (keys%ddHash) {
	print "$k\n";
}

sub process {
	$firstLine = $_[0];

	($p1,$p2) = split(/<dim>/,$firstLine);
	@temp1 = split(/\s+/,$p2);

	#print "$temp1[2]\n";
	$ddHash{$temp1[2]}++;
}
