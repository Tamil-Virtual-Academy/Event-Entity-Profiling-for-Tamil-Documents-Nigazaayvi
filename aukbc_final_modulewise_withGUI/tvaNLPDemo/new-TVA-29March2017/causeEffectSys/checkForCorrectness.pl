#!/usr/bin/perl

undef $line;
undef @array;

while(<>) {
        chomp;

        if($_ =~ /^\s*$/) {
                $line = join "L_END", @array;
                push(@fullArray,$line);
                undef @array;
        }else{
                push(@array,$_);
        }
}


for($i = 0;$i < @fullArray;$i++) {
	if(($fullArray[$i] =~ /ARG1-START/) && ($fullArray[$i] =~ /ARG2-START/) && ($fullArray[$i] =~ /ARG1-END/) && ($fullArray[$i] =~ /ARG2-END/)) {
	}elsif(($fullArray[$i-1] =~ /ARG1-START/) && ($fullArray[$i] =~ /ARG2-START/) && ($fullArray[$i-1] =~ /ARG1-END/) && ($fullArray[$i] =~ /ARG2-END/)) {
	}elsif(($fullArray[$i] =~ /ARG1-START/) && ($fullArray[$i+1] =~ /ARG2-START/) && ($fullArray[$i] =~ /ARG1-END/) && ($fullArray[$i+1] =~ /ARG2-END/)) {
	}else{
		$fullArray[$i] =~ s/<ARG1-START>/O/;
		$fullArray[$i] =~ s/<ARG2-START>/O/;
		$fullArray[$i] =~ s/<ARG1-END>/O/;
		$fullArray[$i] =~ s/<ARG2-END>/O/;

		if($fullArray[$i] =~ /\t<CON>\t/i) {
			correctCE_tags($i);
		}
	}
}

sub correctCE_tags {
	$position = $i;
        @tempW = split(/L_END/,$fullArray[$position]);

	$l = @tempW;

	$ceTggedF = 0;
        for($ijk = 0;$ijk < @tempW;$ijk++) {
                #print "$k\n";
		if(($tempW[$ijk] =~ /<CON>/) && ($tempW[$ijk] =~ /awAl/) && (($tempW[$ijk] =~ /V_VM_VNF_COND/)||($tempW[$ijk] =~ /CC_CCS/))) {
			$tempW[$ijk] =~ s/\tO$/\t<ARG1-END>/;
			$tempW[0] =~ s/\tO$/\t<ARG1-START>/;
			if($tempW[$ijk+1] =~ /^\w+/) {
				$tempW[$ijk+1] =~ s/\tO$/\t<ARG2-START>/;
			}else{
				$tempW[$ijk+2] =~ s/\tO$/\t<ARG2-START>/;
			}
			if($tempW[$l-1] =~ /^\w+/) {
				$tempW[$l-1] =~ s/\tO$/\t<ARG2-END>/;
			}else{
				$tempW[$l-2] =~ s/\tO$/\t<ARG2-END>/;
			}

			$ceTggedF = 1;
			$newLine = join "L_END", @tempW;
			$fullArray[$position] = $newLine;
			last;
		}
        }
        #print "\n";

	if($ceTggedF == 0) {
        	for($ijk = 0;$ijk < @tempW;$ijk++) {
			if($tempW[$ijk] =~ /<CON>/) {
				if($ijk == 0) {
					#print "$tempW[$ijk]\n";

					# correct ARG2
	                      		if($tempW[$ijk+1] =~ /^\w+/) {
        	                	        $tempW[$ijk+1] =~ s/\tO$/\t<ARG2-START>/;
                	        	}else{
                        		        $tempW[$ijk+2] =~ s/\tO$/\t<ARG2-START>/;
                        		}
					if($tempW[$l-1] =~ /^\w+/) {
						$tempW[$l-1] =~ s/\tO$/\t<ARG2-END>/;
					}else{
						$tempW[$l-2] =~ s/\tO$/\t<ARG2-END>/;
					}

					#Now correct ARG1
					@tempW_prev = split(/L_END/,$fullArray[$position-1]);	

					$l2 = @tempW_prev;

					$tempW_prev[0] =~ s/\tO$/\t<ARG1-START>/;

					if($tempW_prev[$l2-1] =~ /^\w+/) {
						$tempW_prev[$l2-1] =~ s/\tO$/\t<ARG1-END>/;
					}else{
						$tempW_prev[$l2-2] =~ s/\tO$/\t<ARG1-END>/;
					}

					$newLine_prev = join "L_END", @tempW_prev;
					$fullArray[$position-1] = $newLine_prev;

					$newLine = join "L_END", @tempW;
					$fullArray[$position] = $newLine;
				}else{
					#print "$tempW[$ijk]\n";

					#print join "\n", @tempW,"\n";
				}
			}
		}
	}
}

foreach $line (@fullArray) {

	@tempW = split(/L_END/,$line);

	for $k (@tempW) {
		print "$k\n";
	}
	print "\n";
}

