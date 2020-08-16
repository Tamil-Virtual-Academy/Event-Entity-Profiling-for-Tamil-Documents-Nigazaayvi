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
		if($array[$i] =~ /\s+PR_/) {
			printReqLines($array[$i],$i);
		}
	}
}

sub printReqLines {
	($line,$position) = @_;

	undef $startLines;
	undef $endLines;

	$len = @array;
	$len--;

	if($position == 0) {
		$startLines = "0\t0\tstart\tstart\tstart\t0\tFALSE\n0\t0\tstart\tstart\tstart\t0\tFALSE";
	}elsif($position == 1) {
		$startLines = "0\t0\tstart\tstart\tstart\t0\tFALSE";
	}
	
	if($position == $l) {
		$endLines ="0\t0\tend\tend\tend\t0\tFALSE\n0\t0\tend\tend\tend\t0\tFALSE";
	}elsif($position == ($l-1)) {
		$endLines ="0\t0\tend\tend\tend\t0\tFALSE";
	}

	undef $requiredLines;
	if($position -2 >= 0) {
		@tempArra = split(/\s+/,$array[$position-2]);
		$seg = "$tempArra[1]\t$tempArra[2]\t$tempArra[3]\t$tempArra[4]\t$tempArra[5]\t0\t";

		#if($array[$position-2] =~ /Ana$/i) {
		#	$seg = $seg."TRUE";
		#}else{
			$seg = $seg."FALSE";
		#}

		$requiredLines = $requiredLines."$seg\n";
	}
	if($position -1 >= 0) {
		@tempArra = split(/\s+/,$array[$position-1]);
		$seg = "$tempArra[1]\t$tempArra[2]\t$tempArra[3]\t$tempArra[4]\t$tempArra[5]\t0\t";

		#if($array[$position-1] =~ /Ana$/i) {
		#	$seg = $seg."TRUE";
		#}else{
			$seg = $seg."FALSE";
		#}

		$requiredLines = $requiredLines."$seg\n";
	}
	
	@tempArra = split(/\s+/,$array[$position]);
	$seg = "$tempArra[1]\t$tempArra[2]\t$tempArra[3]\t$tempArra[4]\t$tempArra[5]\t1\t";

	#if($array[$position] =~ /Ana$/i) {
	#	$seg = $seg."TRUE";
	#}else{
		$seg = $seg."FALSE";
	#}

	$requiredLines = $requiredLines."$seg\n";
	
	if($position +1 <= $len) {
		@tempArra = split(/\s+/,$array[$position+1]);
		$seg = "$tempArra[1]\t$tempArra[2]\t$tempArra[3]\t$tempArra[4]\t$tempArra[5]\t0\t";

		#if($array[$position+1] =~ /Ana$/i) {
		#	$seg = $seg."TRUE";
		#}else{
			$seg = $seg."FALSE";
		#}
		$requiredLines = $requiredLines."$seg\n";
	}
	if($position +2 <= $len) {
		@tempArra = split(/\s+/,$array[$position+2]);
		$seg = "$tempArra[1]\t$tempArra[2]\t$tempArra[3]\t$tempArra[4]\t$tempArra[5]\t0\t";

		#if($array[$position+2] =~ /Ana$/i) {
		#	$seg = $seg."TRUE";
		#}else{
			$seg = $seg."FALSE";
		#}
		$requiredLines = $requiredLines."$seg\n";
	}

	if($startLines ne undef) {print "$startLines\n";}
	print "$requiredLines";
	if($endLines ne undef) {print "$endLines\n";}

	print "\n";
}
