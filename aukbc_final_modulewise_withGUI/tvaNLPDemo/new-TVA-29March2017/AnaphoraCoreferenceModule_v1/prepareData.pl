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

if(@array ne undef) {
	process(@array);
}


sub process {
	for($i = 0;$i < @array;$i++) {
		@tempA = split(/\s+/,$array[$i]);
		$l = @tempA;

		if($l == 8) {
			$array[$i] = $array[$i]." o";
		}elsif($l == 7) {
			$array[$i] = $array[$i]." o   o";
		}elsif($l == 6) {
			$array[$i] = $array[$i]." o   o   o";
		}

		@tempB = split(/\s+/,$array[$i]);
		$l1 = @tempB;

		print "$array[$i]\n";
	}
	print "\n";
}

