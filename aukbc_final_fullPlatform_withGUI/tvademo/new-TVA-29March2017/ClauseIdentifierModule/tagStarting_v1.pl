#!/usr/bin/perl

undef @array;
undef @tagDetails;
undef @tagPosition;

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
	
	$l = @array;
	$l--;
	$tag = "";
	$mclFlag = 0;

	for($i =$l;$i >= 0;$i--) {
		if($array[$i] =~ /\t\{\/(\w+)\}$/) {
			$tag = $1;
			push(@tagDetails,$tag);
			push(@tagPosition,$i);
			if($tag =~ /\{\/MCL\}/) {
				$mclFlag = 1;
			}
		}
		if($tag ne undef) {
			if($i == 0) {
				$array[$i] =~ s/\to$/\t{$tag}/;
			}elsif(($array[$i] =~ /\to$/) && ($array[$i-1] =~ /\t\{\/(\w+)\}$/)){
				$array[$i] =~ s/\to$/\t{$tag}/;
			}
		}
	}

	if($mclFlag == 0) {
		$aLength = @array;
		$aLength--;

		$mclToBeTagged = $tagPosition[0]+1;

		if($mclToBeTagged < $aLength) {
			$array[$mclToBeTagged] =~ s/\to$/\t{MCL}/;
			$array[$aLength] =~ s/\to$/\t{\/MCL}/;
		}
	}

	print join "\n", @array,"\n";
}
