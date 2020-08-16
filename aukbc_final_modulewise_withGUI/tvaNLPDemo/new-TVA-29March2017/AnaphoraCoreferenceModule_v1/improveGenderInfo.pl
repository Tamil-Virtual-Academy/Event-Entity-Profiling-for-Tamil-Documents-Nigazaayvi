#!/usr/bin/perl

open(RE,"Gender-Tagged.txt");
while(<RE>) {
	chomp;

	if($_ =~ /\,/) {
		($word,$gender,$number) = split(/\,/,$_);
		$gender = lc($gender);
		$hash{$word} = $gender;
		$number = lc($number);

		$hash_number{$word} = $number if($number =~ /pl/i)
	}
}
close(RE);

while(<>) {
	chomp;

	if($_ =~ /^\s*$/)  {
		print "\n";
		next;
	}

	@tempA = split(/\s+/,$_);

	$morphInfo = $tempA[6];
	@detailMA = split(/\,/,$morphInfo);

	if($morphInfo =~ /\,N\,/) {
		#print "$detailMA[0]\-$detailMA[5]\n";		
		if(exists $hash{$detailMA[0]}) {
			$detailMA[5] = $hash{$detailMA[0]};
			#print STDERR "$detailMA[0]\n";
		}
		if(exists $hash_number{$detailMA[0]}) {
			$detailMA[3] = $hash_number{$detailMA[0]};
		}
	}
	if(($tempA[7] =~ /((INDIVIDUAL)|(PERSON)|(GROUP))/) && ($detailMA[5] eq "")) {
		$detailMA[5] = "mf";
		if($morphInfo =~ /unk/) {
			$detailMA[1] = "N";
		}
		if($tempA[7] =~ /GROUP/) {
			$detailMA[3] = "pl";
		}	
		#print STDERR "$detailMA[0] --- $tempA[7]\n";
	}
	$newMorphInfo = join "\,", @detailMA; 
	$tempA[6] = $newMorphInfo;
	
	$line = join "  ", @tempA;

	$line =~ s/^\s*//;
	$line =~ s/\s*$//;

	print "$line\n";
}
