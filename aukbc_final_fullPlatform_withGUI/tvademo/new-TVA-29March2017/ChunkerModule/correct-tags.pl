#!/usr/bin/perl

while(<>) {
	chomp ($_);
	push(@array, $_);
}

process();
process();

for($i = 0;$i < @array;$i++) {
	print "$array[$i]\n";
}

sub process {
$i = 0;
while($i < @array) {
	if ($array[$i] =~ /^(.*[BI]-VGNF)$/) {
		if ($array[$i+1] =~ /^(.*B-VGNF)$/) {
			$array[$i+1] =~ s/B\-VGNF/I-VGNF/ if ($array[$i] =~ /[BI]\-VGNF/);
		}
	}
	if ($array[$i] =~ /\t[BI]\-RBP$/) {
		if ($array[$i+1] =~ /^(.*B-(V\w+))$/) {
			$newTag = $2;
			#print STDERR "5634576568568986765\n";
			$array[$i+1] =~ s/B\-$newTag/I-$newTag/;
			$array[$i] =~ s/B-RBP/B\-$newTag/;
			$array[$i] =~ s/I-RBP/I\-$newTag/;
		}
	}

	if ($array[$i] =~ /^(.*B-VGNF)$/) {
		if ($array[$i+1] =~ /^(.*(VGF).*)/ ) { 
			$array[$i] =~ s/B\-VGNF/B\-VGF/;
			$array[$i+1] =~ s/B\-VGF/I\-VGF/ if($array[$i] =~ /[B]\-VGF/);
		}
	}
	if ($array[$i] =~ /^(.*B-VGNF)$/) {
		if ($array[$i+1] =~ /^(.*I-VGNF)$/) {
        		if ($array[$i+2] =~ /^(.*(VGF).*)/ ) {
                        	$array[$i] =~ s/B\-VGNF/B\-VGF/;
				$array[$i+1] =~ s/I\-VGNF/I-VGF/;
                        	$array[$i+2] =~ s/B\-VGF/I\-VGF/ if($array[$i] =~ /[B]\-VGF/);
                	}
		}
	}	
	if ($array[$i] =~ /^(.*B-VGNF)$/) {
        	if ($array[$i+1] =~ /^(.*I-VGNF)$/) {
			if ($array[$i+2] =~ /^(.*I-VGNF)$/) {
        			if ($array[$i+3] =~ /^(.*(VGF).*)/ ) {
                        		$array[$i] =~ s/B\-VGNF/B\-VGF/;
                        		$array[$i+1] =~ s/I\-VGNF/I-VGF/;
					$array[$i+2] =~ s/I\-VGNF/I-VGF/;
                        		$array[$i+3] =~ s/B\-VGF/I\-VGF/ if($array[$i] =~ /[B]\-VGF/);
                		}
                	}
                }
	}
	if ($array[$i] !~ /\|/) {
		if ($array[$i] =~ /^(.*,v,.*finite="Y".*)$/) {
			$array[$i] =~ s/N_NN/V_VM_VF/;
			$array[$i] =~ s/[B]-NP/B-VGF/;
			$array[$i] =~ s/[I]-NP/I-VGF/;
		}
		if ($array[$i] =~ /_VBP/) {
			if ($array[$i+1] =~ /^(.*VGF.*)$/) {
				$array[$i] =~ s/NN/VM/;
				$array[$i] =~ s/VGF/VGNF/;
				$array[$i+1] =~ s/VGF/VGNF/ if ($array[$i] =~ /VGNF/);
                	}
		}
		if ($array[$i] =~ /_INF/) {
			if ($array[$i+1] =~ /^(.*VGF.*)$/) {
				$array[$i] =~ s/NN/VM/;
				$array[$i] =~ s/VGF/VGNF/;
				$array[$i+1] =~ s/VGF/VGNF/ if ($array[$i] =~ /VGNF/);
			}
		}
	}	
	$i++;
}
}
