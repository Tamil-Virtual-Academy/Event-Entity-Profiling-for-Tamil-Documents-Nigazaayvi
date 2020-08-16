#!/usr/bin/perl

$sentStruc = "";

while(<>) {
	chomp;

	if($_ =~ /^\s*$/) {
		#print STDERR "$sentStruc\n";
		if($sentStruc =~ /\{\/RP\}\{MCL\}/) {
			#print STDERR "Requires Processing\n";
			process(@array);
		}else{
			print join "\n", @array,"\n";
		}
	}else{
		if($_ =~ /\}\s*$/) {
			@temp = split(/\t/,$_);
			$last = pop(@temp);
			$sentStruc = $sentStruc.$last;
		}
		push(@array,$_);
	}
}

sub process {
	my @newArray  = @_;

	$l = @newArray;
	$l--;

	$mclPosition = 0;
	$inbtwTag = 0;
	$checkFlag = 0;

	for($ijk =$l;$ijk >= 0;$ijk--) {
		if(($array[$ijk] =~ /\{\/?\w+\}$/) && ($checkFlag == 1)) {
			$inbtwTag++;
		}

		if($array[$ijk] =~ /\t\{MCL\}$/) {$checkFlag = 1;$mclPosition = $ijk;}

		#print "$array[$ijk] -- $checkFlag -- $inbtwTag \n";
		if(($array[$ijk] =~ /\{\/RP\}$/) && ($inbtwTag == 1)) {
			#print "I have  some work here\n";

			$d = $ijk;
			while($d != 0) {
				if(($array[$d] =~ /\tV_VM_VNF_RP\t/) && ($array[$d+1] =~ /B\-NP/)) {
					$array[$d+1] =~ s/\to$/\t{MCL}/;
					$array[$mclPosition] =~ s/\t{MCL}/\to/;
					last;
				}
				$d--;
			}
			print join "\n", @array,"\n";
		}else{
			#print join "\n", @array,"\n";
		}	
	}

}
