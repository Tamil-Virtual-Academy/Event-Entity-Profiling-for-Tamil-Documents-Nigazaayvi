#!/usr/bin/perl

while(<>) {
	chomp;
	#next if($_ eq undef);
	push(@array,$_);
}


$i = 0;
while($i < @array) {
	if($array[$i] =~ /^\w+([kcwp])\tN_NN/) {
		$start = $1;
		#print STDERR "$start\n";
		if($array[$i+1] =~ /$start\w+\tN_NN/ ) { 
			#print STDERR "$array[$i+1]\n";
			$array[$i+1] =~ s/B\-NP/I\-NP/ if($array[$i] =~ /[BI]\-NP/);
		}
	}
	$i++;
}

for($i = 0;$i < @array;$i++) {
	print "$array[$i]\n";
}
