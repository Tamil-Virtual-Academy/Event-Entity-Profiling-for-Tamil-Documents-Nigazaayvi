#!/usr/bin/perl

$sentId = 0;
$wordId = 0;

$inpFile = $ARGV[0];

open(RE,$inpFile);

while(<RE>) {
	chomp;

	if($_ =~ /^\s*$/) {
		$sentId++;
		$wordId = 0;
	}else{
		if($_ =~ /\s+((avanY)|(avalY)|(avar))/) {
			$fileContent[$sentId][$wordId] = $_."   TRUE";
		}else{
			$fileContent[$sentId][$wordId] = $_."   FALSE";
		}
		$wordId++;
	}
}
close(RE);

$ana_nonAnaOutFile = $ARGV[1];

undef @smallArray;
open(RE,$ana_nonAnaOutFile);
while(<RE>) {
	chomp;

	if($_ =~ /^\s*$/) {
		process(@smallArray);
		undef @smallArray;
	}else{
		push(@smallArray,$_);
	}
}
close(RE);

sub process {
	my @newArray = @_;

	foreach $nArr (@newArray) {
		if($nArr =~ /\t1\tFALSE\tTRUE$/) {
			#print "$nArr\n";
			@temppArr = split(/\t/,$nArr);
			$fileContent[$temppArr[0]][$temppArr[1]] =~ s/FALSE$/TRUE/;
		}
	}
}

for($i = 0;$i< @fileContent;$i++) {
        for($j = 0; $j < @{$fileContent[$i]};$j++) {	
		print "$fileContent[$i][$j]\n";
	}
	print "\n";
}
