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

sub process {
	$ceFlag = 0;

	for($i = 0;$i< @array;$i++) {
		$k = $array[$i];
		if(($k =~ /V,PAST,,,,RP/) || ($k =~ /neg_rp-RP/)) {
			#print "\n~~$k\n";
			
			$state = lookForNP($i);
			#print "STATE --- $state\n";

			if($state == 1) {
				$array[0] =~s/\tO$/\t<ARG1-START>/;
				$l = @array;
				if($array[$l-1] =~ /RD_PUNC/) {
					$array[$l-2] =~ s/\tO$/\t<ARG2-END>/;
				}else{
					$array[$l-1] =~ s/\tO$/\t<ARG2-END>/;
				}

				print join "\n", @array,"\n";
				$ceFlag = 1;
				last;
			}
		}
	}
	if($ceFlag == 0) {
		print join "\n", @array,"\n";
	}
}

sub lookForNP {
	$presentposition = $_[0];

	$presentposition++;

	$locNPFlag = 0;
	if($array[$presentposition] =~ /B\-NP/) {
		$j = $presentposition;
		if($array[$j] =~ /B\-NP/) {
			$startNP = 1;
			$d = $j;
			$true = 1;
			while($true) {
				if($array[$d] =~ /[BI]\-NP/) {
					if(($array[$d] =~ /B\-NP/) && ($startNP > 1)) {$true = 0;last;}
					$startNP++;
					if (($array[$d] =~ /il-LOC/) && ($array[$d+1] !~ /\tirunwu\t/)){
						#rint "$array[$d]\n\n";
						$array[$d] = $array[$d]."\t<ARG1-END>";

						if($array[$d+1] =~ /^\w+/) {
							$array[$d+1] = $array[$d+1]."\t<ARG2-START>";
						}else{
							$array[$d+2] = $array[$d+2]."\t<ARG2-START>";
						}
						$locNPFlag = 1;
						$true = 0;
					}else{
						$d++;
					}
				}else{
					$true = 0;
				}
				if($d > @array) {
					$true = 0;
				}
			}
		}		
	}

	if($locNPFlag == 1) {
		return(1);
	}else{
		return(0);
	}
}
